//
//  ARRBaseFetchedController.h
//  ArticlesReader
//
//  Created by Sapa Denys on 23.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRBaseFetchedController : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, nullable) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, weak, nullable) UITableView *tableView;

- (nonnull id)objectAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (NSUInteger)countInSection:(NSUInteger)section;

@end
