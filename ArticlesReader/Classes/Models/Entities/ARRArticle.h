//
//  ARRArticle.h
//  
//
//  Created by Sapa Denys on 23.05.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARRArticle : NSManagedObject

+ (NSString *)entityName;

@end

NS_ASSUME_NONNULL_END

#import "ARRArticle+CoreDataProperties.h"
