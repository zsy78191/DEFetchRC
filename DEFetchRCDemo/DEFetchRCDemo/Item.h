//
//  Item.h
//  DEFetchRCDemo
//
//  Created by 张超 on 15/12/25.
//  Copyright © 2015年 gerinn. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Item : NSManagedObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSDate* date;
@end
