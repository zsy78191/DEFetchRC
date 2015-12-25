//
//  DETableViewFetchRC.m
//  Deacon
//
//  Created by 张超 on 15/1/30.
//  Copyright (c) 2015年 Gerinn. All rights reserved.
//

#import "DETableViewFetchRC.h"

@implementation DETableViewFetchRC


+ (instancetype)fetchRCWithView:(id)targetView
                          reciver:(id)reciver
                    managedContext:(NSManagedObjectContext *)context
                        entityName:(NSString *)entityName
                           sortKey:(NSString *)key
                         ascending:(BOOL)ascending
                         predicate:(NSPredicate *)predicate
{
    DETableViewFetchRC* fetchRC = [[DETableViewFetchRC alloc] init];
    fetchRC.entityName      = entityName;
    fetchRC.managedContext  = context;
    fetchRC.dataReciver     = reciver;
    fetchRC.sortKey         = key;
    fetchRC.ascending       = ascending;
    fetchRC.predicate       = predicate;
    fetchRC.tableView       = targetView;
    fetchRC.canEdit         = NO;
    return fetchRC;
}

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.dataSource = self;
}

#pragma mark - Table View Delegate

- (BOOL)checkDataSourceCanResponse:(SEL)sel
{
    if (!self.dataReciver) return NO;
    return [self.dataReciver respondsToSelector:sel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self checkDataSourceCanResponse:@selector(tableView:cellAtIndexPath:withData:)])
    {
        NSManagedObject *data = [self.fetchController objectAtIndexPath:indexPath];
        return [self.dataReciver tableView:tableView cellAtIndexPath:indexPath withData:data];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.canEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.dataReciver && [self.dataReciver respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
            [self.dataReciver tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
        }
        NSManagedObject* obj = [self.fetchController objectAtIndexPath:indexPath];
        [self.managedContext deleteObject:obj];
        [self.managedContext save:nil];
    }
    
    if (self.dataReciver && [self.dataReciver respondsToSelector:@selector(tableView:finishCommitEditingStyle:forRowAtIndexPath:)]) {
        [self.dataReciver tableView:tableView finishCommitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

#pragma mark - fetch


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationLeft];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(NSManagedObject*)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
