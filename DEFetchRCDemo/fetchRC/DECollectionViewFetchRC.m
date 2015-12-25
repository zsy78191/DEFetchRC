//
//  DECollectionViewFetchRC.m
//  Deacon
//
//  Created by 张超 on 15/2/2.
//  Copyright (c) 2015年 Gerinn. All rights reserved.
//

#import "DECollectionViewFetchRC.h"

@implementation DECollectionViewFetchRC

+ (instancetype)fetchRCWithView:(id)targetView
                        reciver:(id)reciver
                 managedContext:(NSManagedObjectContext *)context
                     entityName:(NSString *)entityName
                        sortKey:(NSString *)key
                      ascending:(BOOL)ascending
                      predicate:(NSPredicate *)predicate
{
    DECollectionViewFetchRC* fetchRC = [[DECollectionViewFetchRC alloc] init];
    fetchRC.entityName      = entityName;
    fetchRC.managedContext  = context;
    fetchRC.dataReciver     = reciver;
    fetchRC.sortKey         = @"timeStamp";
    fetchRC.ascending       = ascending;
    fetchRC.predicate       = predicate;
    fetchRC.collectionView  = targetView;
    return fetchRC;
}


- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    _collectionView.dataSource = self;
}

- (BOOL)checkDataSourceCanResponse:(SEL)sel
{
    if (!self.dataReciver) return NO;
    return [self.dataReciver respondsToSelector:sel];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[self.fetchController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self checkDataSourceCanResponse:@selector(collectionView:cellAtIndexPath:withData:)])
    {
        NSManagedObject *data = [self.fetchController objectAtIndexPath:indexPath];
        return [self.dataReciver collectionView:collectionView cellAtIndexPath:indexPath withData:data];
    }
    return nil;
}


@end
