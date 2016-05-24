//
//  ARRBaseHTTPRequest.h
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRBaseHTTPRequest : NSObject

@property (readonly) NSDictionary *parameters;
@property (readonly) NSString *path;

@end
