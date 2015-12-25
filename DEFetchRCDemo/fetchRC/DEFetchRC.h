//
//  DEFetchRC.h
//  Deacon
//
//  Created by 张超 on 15/1/30.
//  Copyright (c) 2015年 Gerinn. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface DEFetchRC : NSObject <NSFetchedResultsControllerDelegate>
@property (nonatomic, assign) BOOL                        ascending;
@property (nonatomic, strong) NSFetchedResultsController* fetchController;
@property (nonatomic, strong) NSPredicate*                predicate;
@property (nonatomic, strong) NSString*                   entityName;
@property (nonatomic, strong) NSString*                   sortKey;
@property (nonatomic,   weak) NSManagedObjectContext*     managedContext;

+ (instancetype)fetchRCWithView:(id)targetView
                        reciver:(id)reciver
                 managedContext:(NSManagedObjectContext *)context
                     entityName:(NSString *)entityName
                        sortKey:(NSString *)key
                      ascending:(BOOL)ascending
                      predicate:(NSPredicate *)predicate;

- (void)deleteManageObjectAtIndexPath:(NSIndexPath*)path;
- (id)objectAtIndex:(NSIndexPath*)path;
@end
