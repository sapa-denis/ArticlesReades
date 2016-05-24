//
//  ARRArticle+CoreDataProperties.h
//  
//
//  Created by Sapa Denys on 23.05.16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ARRArticle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ARRArticle (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *articleID;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *imageURLString;
@property (nullable, nonatomic, retain) NSString *previewImageURLString;
@property (nullable, nonatomic, retain) NSString *contentURLString;

@end

NS_ASSUME_NONNULL_END
