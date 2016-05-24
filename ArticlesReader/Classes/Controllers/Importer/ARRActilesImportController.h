//
//  ARRActilesImportController.h
//  ArticlesReader
//
//  Created by Sapa Denys on 23.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRActilesImportController : NSObject

- (void)importResponse:(NSArray *)responseObject withSuccess:(void (^)(id result))success;

@end
