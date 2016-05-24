//
//  ARRBackgroundHTMLCacheController.h
//  ArticlesReader
//
//  Created by Sapa Denys on 24.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRBackgroundHTMLCacheController : NSObject

+ (void)downloadArticles:(NSArray <NSString *> *)articleURLs;
+ (NSString *)preloadedArticleWithID:(NSNumber *)articleID;
+ (BOOL)deleteOldArticleWithID:(NSNumber *)articleID;

@end
