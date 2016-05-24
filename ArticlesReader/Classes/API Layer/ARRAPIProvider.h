//
//  ARRAPIProvider.h
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRAPIProvider : NSObject

+ (ARRAPIProvider *)sharedProvider;

- (void)getArticlesWithSuccess:(void (^)(id result))success
					   failure:(void (^)(NSError *error))failure;

@end
