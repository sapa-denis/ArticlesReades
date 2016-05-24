//
//  ARRBaseHTTPClient.m
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRBaseHTTPClient.h"

#import <AFNetworking/AFNetworking.h>

@interface ARRBaseHTTPClient ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ARRBaseHTTPClient

- (instancetype)initWithBaseURL:(NSString *)baseURL
{
	self = [super init];
	if (self) {
		_sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
		_sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
		_sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
	}
	return self;
}

- (void)postNewRequest:(nonnull NSString *)path
			parameters:(nullable NSDictionary *)parameters
			   success:(nullable void (^)(id _Nullable responseObject))success
			   failure:(nullable void (^)(NSError *_Nullable error))failure
{
	[self.sessionManager POST:path
				   parameters:parameters
					 progress:nil
					  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
						  NSLog(@"(%@) ✅ %@", path, responseObject);
						  if (success) {
							  success(responseObject);
						  }
					  }
					  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
						  if (failure) {
							  failure(error);
						  }
					  }];
}

- (void)getNewRequestWithEndpoint:(nonnull NSString *)path
					   parameters:(nullable NSDictionary *)parameters
						  success:(nullable void (^)(id _Nullable responseObject))success
						  failure:(nullable void (^)(NSError *_Nullable error))failure
{
	[self.sessionManager GET:path parameters:parameters progress:nil
					 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
						 NSLog(@"(%@) ✅ %@", path, responseObject);
						 if (success) {
							 success(responseObject);
						 }
					 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
						 if (failure) {
							 failure(error);
						 }
					 }];
}

@end
