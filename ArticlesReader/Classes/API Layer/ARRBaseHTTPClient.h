//
//  ARRBaseHTTPClient.h
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRBaseHTTPClient : NSObject

- (instancetype)initWithBaseURL:(nullable NSString *)baseURL;

- (void)postNewRequest:(nonnull NSString *)path
			parameters:(nullable NSDictionary *)parameters
			   success:(nullable void (^)(id _Nullable responseObject))success
			   failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)getNewRequestWithEndpoint:(nonnull NSString *)path
					   parameters:(nullable NSDictionary *)parameters
						  success:(nullable void (^)(id _Nullable responseObject))success
						  failure:(nullable void (^)(NSError *_Nullable error))failure;

@end
