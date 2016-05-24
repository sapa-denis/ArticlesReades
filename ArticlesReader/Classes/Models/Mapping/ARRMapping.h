//
//  ARRMapping.h
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FastEasyMapping/FastEasyMapping.h>

#import "ARRArticle.h"

@interface ARRArticle (Mapping)
+ (FEMMapping *)defaultMapping;
@end
