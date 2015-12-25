//
//  ViewController.m
//  DEFetchRCDemo
//
//  Created by 张超 on 15/12/25.
//  Copyright © 2015年 gerinn. All rights reserved.
//

#import "ViewController.h"
#import "DETableViewFetchRC.h"
#import "AppDelegate.h"
#import "Item.h"
@interface ViewController () <DETableViewFetchDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DETableViewFetchRC* tableFetchResultController;
@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableFooterView = [UIView new];
    
    [self.managedObjectContext setUndoManager:[[NSUndoManager alloc] init]];
    
    
    self.tableFetchResultController = [DETableViewFetchRC fetchRCWithView:self.tableView
                                                                  reciver:self
                                                           managedContext:self.managedObjectContext
                                                               entityName:@"Item"
                                                                  sortKey:@"date"
                                                                ascending:YES
                                                                predicate:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellAtIndexPath:(NSIndexPath *)indexPath withData:(id)data
{
    Item* item = data;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = [item.date description];
    return cell;
}

- (NSManagedObjectContext*)managedObjectContext
{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    return delegate.managedObjectContext;
}


- (IBAction)addNew:(id)sender {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Item"
                                                         inManagedObjectContext:self.managedObjectContext];
    
    Item* obj = (Item*)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    
    obj.title = @"Item";
    obj.date = [NSDate date];
    
    NSLog(@"add new %@",obj);
}


- (void)deleteObject:(NSManagedObject *)object {
    [self.managedObjectContext deleteObject:object];
}

- (IBAction)undo:(id)sender;
{
    [self.managedObjectContext undo];
}

- (void)redo
{
    [self.managedObjectContext redo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
