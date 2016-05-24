//
//  ARRBackgroundHTMLCacheController.m
//  ArticlesReader
//
//  Created by Sapa Denys on 24.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRBackgroundHTMLCacheController.h"

@implementation ARRBackgroundHTMLCacheController

+ (void)downloadArticles:(NSArray <NSString *> *)articleURLs
{
	dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
	for (NSString *articleURL in articleURLs) {
		NSString *articleID = [[articleURL componentsSeparatedByString:@"/"] lastObject];
		NSString *filePath = [ARRBackgroundHTMLCacheController documentFilePathWithID:articleID];
		
		dispatch_async(queue, ^{
			NSData *urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:articleURL]];
			[urlData writeToFile:filePath atomically:YES];
		});
	}
}

+ (NSString *)preloadedArticleWithID:(NSNumber *)articleID
{
	NSString *filePath = [ARRBackgroundHTMLCacheController documentFilePathWithID:articleID];
	
	NSError *error = nil;
	NSString *htmlString = [NSString stringWithContentsOfFile:filePath
													 encoding:NSUTF8StringEncoding
														error:&error];
	
	if (error) {
		NSLog(@"%@ %@",NSStringFromSelector(_cmd), error.localizedDescription);
	}
	return htmlString;
}

+ (BOOL)deleteOldArticleWithID:(NSNumber *)articleID
{
	NSString *filePath = [ARRBackgroundHTMLCacheController documentFilePathWithID:articleID];
	NSError *error = nil;
	[[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
	if (error) {
		NSLog(@"Deleting file error: %@", error.localizedDescription);
	}
	return error;
}

+ (NSString *)documentFilePathWithID:(id)ID
{
	NSString *documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	NSString *filePath = [documentDir stringByAppendingPathComponent:
						  [NSString stringWithFormat:@"%@.html", ID]];
	return filePath;
}

@end
