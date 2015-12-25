//
//  DETableViewFetchRC.h
//  Deacon
//
//  Created by 张超 on 15/1/30.
//  Copyright (c) 2015年 Gerinn. All rights reserved.
//

#import "DEFetchRC.h"
#import <UIKit/UIKit.h>
@protocol DETableViewFetchDelegate <NSObject>
@required
- (UITableViewCell*)tableView:(UITableView*)tableView cellAtIndexPath:(NSIndexPath*)indexPath withData:(id)data;
@optional
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView finishCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface DETableViewFetchRC : DEFetchRC <UITableViewDataSource>
@property (nonatomic, assign) id<DETableViewFetchDelegate>  dataReciver;
@property (nonatomic,   weak) UITableView*                  tableView;
@property (nonatomic, assign) BOOL canEdit;


@end
