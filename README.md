# DEFetchRC
一个NSFetchedResultsController的简单封装

DETableViewFetchRC将自动绑定CoreData的ManageContext和TableView，绑定好以后，数据的任何变动，包括增删改查，都会自动调用对应Cell的更新，不需要自己写任何代码做通知挂钩等。

Demo中使用Apple的CoreData模版，CoreData的Context在AppDelegate中。

```
- (NSManagedObjectContext*)managedObjectContext
{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    return delegate.managedObjectContext;
}
```

##DETableViewFetchRC初始化

```
@property (nonatomic, strong) DETableViewFetchRC* tableFetchResultController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.managedObjectContext setUndoManager:[[NSUndoManager alloc] init]];
    
   
    self.tableFetchResultController = [DETableViewFetchRC fetchRCWithView:self.tableView
                                                                  reciver:self
                                                           managedContext:self.managedObjectContext
                                                               entityName:@"Item"
                                                                  sortKey:@"date"
                                                                ascending:YES
                                                                predicate:nil];
}
```

其中第一参数输入需要绑定（bind）的 TableView（如果使用DECollectionViewFetchRC则传入CollectionView），第二个参数是DETableViewFetchDelegate的委托，主要用来实现Cell内容填充回调：

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellAtIndexPath:(NSIndexPath *)indexPath withData:(id)data
{
    Item* item = data;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = [item.date description];
    return cell;
}
```

这里的CoreData实例名字是Item，有title和date两个属性，分别为NSString和NSDate。

这样就完成了一步绑定，CoreData的Context有变动时自动更新调用Cell更新回调，更新Cell，增删改都自动完成。效果如下：



