//
//  ARRBaseFetchedController.m
//  ArticlesReader
//
//  Created by Sapa Denys on 23.05.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "ARRBaseFetchedController.h"

@implementation ARRBaseFetchedController

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController
{
	_fetchedResultsController = fetchedResultsController;
	fetchedResultsController.delegate = self;
	[fetchedResultsController performFetch:NULL];
}

- (id)objectAtIndexPath:(nonnull NSIndexPath *)indexPath;
{
	return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSUInteger)countInSection:(NSUInteger)section
{
	NSInteger numberOfRows = 0;
	if ([[self.fetchedResultsController sections] count] > section) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
		numberOfRows = [sectionInfo numberOfObjects];
	}
	return numberOfRows;
}

#pragma mark - NSFetchedResultsControllerDelegate

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
	
	switch(type) {
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
			break;
			
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
			break;
		case NSFetchedResultsChangeUpdate:
			[self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
		default:
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(nullable NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(nullable NSIndexPath *)newIndexPath
{
	switch(type) {
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
			break;
		case NSFetchedResultsChangeInsert:
			[self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
			break;
			
			
		case NSFetchedResultsChangeMove:
			if(![indexPath isEqual:newIndexPath]) {
				[self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
				[self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
			} else {
				[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
			}
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
		default:
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[self.tableView endUpdates];
}


@end
