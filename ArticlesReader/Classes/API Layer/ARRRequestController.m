//
//  ARRAPIManager.m
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRRequestController.h"
#import "ARRBaseHTTPClient.h"

#import "ARRGetArticlesHTTPRequest.h"
#import "ARRActilesImportController.h"

#import "ARRMapping.h"

static NSString *const kARRBaseURL = @"http://madiosgames.com/api/v1/application/ios_test_task/";

@interface ARRRequestController ()

@property (nonatomic, strong) ARRBaseHTTPClient *baseHTTPClient;

@end

@implementation ARRRequestController

- (instancetype)init
{
	self = [super init];
	if (self) {
		_baseHTTPClient = [[ARRBaseHTTPClient alloc] initWithBaseURL:kARRBaseURL];
	}
	return self;
}

- (void)getArticlesWithSuccess:(void (^)(id result))success
					   failure:(void (^)(NSError *error))failure
{
	ARRGetArticlesHTTPRequest *getArticles = [ARRGetArticlesHTTPRequest new];
	
	ARRActilesImportController *importer = [ARRActilesImportController new];
	
	[self.baseHTTPClient getNewRequestWithEndpoint:getArticles.path
										parameters:getArticles.parameters
										   success:^(NSArray * _Nullable responseObject) {
											   

											   [importer importResponse:responseObject withSuccess:success];
										   }
										   failure:^(NSError * _Nullable error) {
											   if (failure) {
												   failure(error);
											   }
										   }];
}


@end
