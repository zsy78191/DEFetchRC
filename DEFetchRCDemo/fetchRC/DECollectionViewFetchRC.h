//
//  DECollectionViewFetchRC.h
//  Deacon
//
//  Created by 张超 on 15/2/2.
//  Copyright (c) 2015年 Gerinn. All rights reserved.
//

#import "DEFetchRC.h"
#import <UIKit/UIKit.h>
@protocol DECollectionViewFetchDelegate <UICollectionViewDataSource>
@required
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellAtIndexPath:(NSIndexPath*)indexPath withData:(id)data;
@end

@interface DECollectionViewFetchRC : DEFetchRC <UICollectionViewDataSource>
@property (nonatomic, assign) id<DECollectionViewFetchDelegate>  dataReciver;
@property (nonatomic,   weak) UICollectionView*                  collectionView;
@end
