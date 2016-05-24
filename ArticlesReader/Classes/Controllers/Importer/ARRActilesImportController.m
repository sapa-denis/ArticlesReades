//
//  ARRActilesImportController.m
//  ArticlesReader
//
//  Created by Sapa Denys on 23.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRActilesImportController.h"

#import "ARRBackgroundHTMLCacheController.h"

#import "AppDelegate.h"
#import "ARRMapping.h"

@interface ARRActilesImportController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation ARRActilesImportController

- (instancetype)init
{
	self = [super init];
	if (self) {
		AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		_managedObjectContext = appDelegate.backgroundManagedObjectContext;
	}
	return self;
}

- (void)importResponse:(NSArray *)responseObject withSuccess:(void (^)())success
{
	FEMMapping *mapping = [ARRArticle defaultMapping];
	NSArray *articles = [FEMDeserializer collectionFromRepresentation:responseObject
										  mapping:mapping
										  context:self.managedObjectContext];
	
	NSLog(@"%ld", [articles count]);
	
	NSMutableArray *articleIDs = [NSMutableArray arrayWithArray:[self fetchAllExistingAttributes:@"articleID"]];
	
	for (ARRArticle *article in articles) {
		NSUInteger index = [articleIDs indexOfObject:article.articleID];
		if (index != NSNotFound) {
			[articleIDs removeObjectAtIndex:index];
		}
	}
	
	[self deleateOldArticles:articleIDs];
	
	NSError *error = nil;
	[self.managedObjectContext save:&error];
	if (success && !error) {
		success(nil);
	}
	
	NSMutableArray *contentURLs = [NSMutableArray arrayWithArray:[self fetchAllExistingAttributes:@"contentURLString"]];
	[ARRBackgroundHTMLCacheController downloadArticles:contentURLs];
}

- (void)deleateOldArticles:(NSArray <NSNumber *> *)articleIDs
{
	for (NSNumber *ID in articleIDs) {
		ARRArticle *article = [self fetchArticleWithIdentifier:ID];
		if (article) {
			[self.managedObjectContext deleteObject:article];
		}
		[ARRBackgroundHTMLCacheController deleteOldArticleWithID:ID];
	}
}

- (ARRArticle *)fetchArticleWithIdentifier:(NSNumber *)identifier
{
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[ARRArticle entityName]];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"articleID = %@", identifier];
	NSError *error = nil;
	NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if (error) {
		NSLog(@"error: %@", error.localizedDescription);
	}
	if (result.lastObject) {
		return result.lastObject;
	}
	return nil;
}

- (NSArray *)fetchAllExistingAttributes:(NSString *)attribute
{
	NSEntityDescription *entity = [NSEntityDescription  entityForName:[ARRArticle entityName]
											   inManagedObjectContext:self.managedObjectContext];
 
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	[request setResultType:NSDictionaryResultType];
	[request setReturnsDistinctResults:YES];
	[request setPropertiesToFetch:@[attribute]];
 
	NSError *error;
	NSArray *rawAttributes = [self.managedObjectContext executeFetchRequest:request error:&error];
	
	NSMutableArray *attributes = [NSMutableArray arrayWithArray:@[]];
	
	for (NSDictionary *item in rawAttributes) {
		[attributes addObject:[item objectForKey:attribute]];
	}

	return attributes;

}

@end
