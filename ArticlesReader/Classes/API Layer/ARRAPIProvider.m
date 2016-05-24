//
//  ARRAPIProvider.m
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRAPIProvider.h"
#import "ARRRequestController.h"

@interface ARRAPIProvider ()

@property (nonatomic, strong) ARRRequestController *requestController;

@end

@implementation ARRAPIProvider

+ (ARRAPIProvider *)sharedProvider
{
	static ARRAPIProvider *sharedProvider;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedProvider = [[ARRAPIProvider alloc] init];
		sharedProvider.requestController = [ARRRequestController new];
	});
	return sharedProvider;
}

- (void)getArticlesWithSuccess:(void (^)())success
					   failure:(void (^)(NSError *error))failure
{
	[self.requestController getArticlesWithSuccess:success failure:failure];
}

@end

