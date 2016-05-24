//
//  ARRBaseHTTPRequest.m
//  ArticlesReader
//
//  Created by Sapa Denys on 22.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRBaseHTTPRequest.h"

@implementation ARRBaseHTTPRequest

- (instancetype)init
{
	self = [super init];
	if (self) {
		_parameters = @{};
		_path = @"";
	}
	return self;
}

@end
