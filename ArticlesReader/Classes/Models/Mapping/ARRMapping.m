//
//  ARRMapping.m
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRMapping.h"


#pragma mark - ARRArticle

@implementation ARRArticle (Mapping)

+ (FEMMapping *)defaultMapping {
	FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"Article"];
	[mapping addAttributesFromArray:@[@"title"]];
	
	[mapping addAttributesFromDictionary:@{ @"articleID" : @"id",
											@"imageURLString" : @"image_medium",
											@"previewImageURLString" : @"image_thumb",
											@"contentURLString" : @"content_url"
											}];
	
	mapping.primaryKey = @"articleID";
	
	return mapping;
}
@end