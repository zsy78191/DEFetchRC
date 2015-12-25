//
//  DEFetchRC.m
//  Deacon
//
//  Created by 张超 on 15/1/30.
//  Copyright (c) 2015年 Gerinn. All rights reserved.
//

#import "DEFetchRC.h"

@implementation DEFetchRC

+ (instancetype)fetchRCWithView:(id)targetView
                        reciver:(id)reciver
                 managedContext:(NSManagedObjectContext *)context
                     entityName:(NSString *)entityName
                        sortKey:(NSString *)key
                      ascending:(BOOL)ascending
                      predicate:(NSPredicate *)predicate
{
    NSAssert(NO, @"Please use function of DEFetchRC's subClass to get instance.");
    return nil;
}

- (NSFetchedResultsController *)fetchController
{
    if (_fetchController != nil) {
        return _fetchController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setPredicate:self.predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:self.sortKey ascending:self.ascending];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    _fetchController= [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedContext sectionNameKeyPath:nil cacheName:nil];
    _fetchController.delegate = self;
    
    NSError *error = nil;
    if (![_fetchController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        ////LOGMARK(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchController;
}

- (void)deleteManageObjectAtIndexPath:(NSIndexPath *)path
{
    NSManagedObject* obj = [self.fetchController objectAtIndexPath:path];
    [self.managedContext deleteObject:obj];
    [self.managedContext save:nil];
}

- (id)objectAtIndex:(NSIndexPath*)path
{
    return [self.fetchController objectAtIndexPath:path];
}

@end
