//
//  ARRArticlesListViewController.m
//  ArticlesReader
//
//  Created by Sapa Denys on 20.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRArticlesListViewController.h"
#import "ARRBaseFetchedController.h"
#import "ARRArticleTableViewCell.h"
#import "ARRArticle.h"

#import "ARRAPIProvider.h"
#import "ARRArticleWebViewController.h"

#import "AppDelegate.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface ARRArticlesListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) ARRBaseFetchedController *dataSource;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ARRArticlesListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	
	self.managedObjectContext = appDelegate.managedObjectContext;
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Article"];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"articleID" ascending:YES]];
	self.dataSource = [[ARRBaseFetchedController alloc] init];
	
	self.dataSource.fetchedResultsController = [[NSFetchedResultsController alloc]
												initWithFetchRequest:request
												managedObjectContext:self.managedObjectContext
												sectionNameKeyPath:nil
												cacheName:nil];
	self.dataSource.tableView = self.tableView;

	
	self.refreshControl = [[UIRefreshControl alloc] init];
	self.refreshControl.tintColor = [UIColor grayColor];
	[self.refreshControl addTarget:self
							action:@selector(reloadArticles)
				  forControlEvents:UIControlEventValueChanged];
	
	[self.tableView addSubview:self.refreshControl];
	[self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
	
	[[ARRAPIProvider sharedProvider] getArticlesWithSuccess:^{
	} failure:^(NSError *error) {
	}];
}


- (void)reloadArticles
{
	if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
		__weak typeof(self) weakSelf = self;
		[[ARRAPIProvider sharedProvider] getArticlesWithSuccess:^{
			[weakSelf.refreshControl endRefreshing];
		} failure:^(NSError *error) {
			[weakSelf.refreshControl endRefreshing];
		}];
	} else {
		[[[UIAlertView alloc] initWithTitle:@"No Internet connection"
									message:nil
								   delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil]
		 show];
		[self.refreshControl endRefreshing];
	}
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataSource countInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ARRArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ARRArticleTableViewCell class])
																	 forIndexPath:indexPath];
	
	ARRArticle *article = [self.dataSource objectAtIndexPath:indexPath];
	
	cell.title.text = article.title;
	[cell.image sd_setImageWithURL:[NSURL URLWithString:article.previewImageURLString]];
	
	return cell;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
	return NO;
}

#pragma mark -

- (id)selectedItem
{
	NSIndexPath* path = self.tableView.indexPathForSelectedRow;
	return path ? [self.dataSource objectAtIndexPath:path] : nil;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ARRShowArticleSegue"]) {
		
		ARRArticle *article = [self selectedItem];
		
		ARRArticleWebViewController *destinationVC = [segue destinationViewController];
		destinationVC.article = article;
	}
}

@end
