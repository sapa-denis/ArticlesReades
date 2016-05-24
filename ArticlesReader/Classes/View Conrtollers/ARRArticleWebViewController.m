//
//  ARRArticleWebViewController.m
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRArticleWebViewController.h"
#import "ARRArticle.h"
#import "ARRBackgroundHTMLCacheController.h"

#import <SDWebImage/SDWebImageDownloader.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface ARRArticleWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ARRArticleWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationItem.title = self.article.title;
	
	if (self.article) {
		[[AFNetworkReachabilityManager sharedManager] startMonitoring];
		if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
			[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.article.contentURLString]]];
		} else {
			
			[self.webView loadHTMLString:[ARRBackgroundHTMLCacheController preloadedArticleWithID:self.article.articleID]
								 baseURL:[NSURL URLWithString:self.article.contentURLString]];
		}
	}
}

- (IBAction)shareButtonTouchUp:(id)sender
{
	__weak typeof(self) weakSelf = self;
	
	
	UIActivityViewController *activity =
	[[UIActivityViewController alloc] initWithActivityItems:@[self.article.contentURLString]
									  applicationActivities:nil];
	
	
	NSArray *excludeActivities = @[UIActivityTypeAirDrop,
								   UIActivityTypePrint,
								   UIActivityTypeAssignToContact,
								   UIActivityTypeSaveToCameraRoll,
								   UIActivityTypePostToFlickr,
								   UIActivityTypePostToVimeo];
	
	activity.excludedActivityTypes = excludeActivities;
	
	if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
	SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
	[downloader downloadImageWithURL:[NSURL URLWithString:self.article.imageURLString]
							 options:0
							progress:nil
						   completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
							   if (image && finished) {
								   NSArray *activityItems = @[image, weakSelf.article.contentURLString];
								   

								   UIActivityViewController *activity =
								   [[UIActivityViewController alloc] initWithActivityItems:activityItems
																	 applicationActivities:nil];
								   [weakSelf presentViewController:activity animated:YES completion:nil];
							   }
						   }];
	} else {
		[self presentViewController:activity animated:YES completion:nil];
	}
}

@end
