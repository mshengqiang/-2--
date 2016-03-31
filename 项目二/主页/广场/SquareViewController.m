//
//  CountriesTableViewController.m
//  UI_hot2动态时钟
//
//  Created by rimi on 16/1/19.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import "SquareViewController.h"
#import "DiaryViewController.h"
#import "ContentViewController.h"
//#import <UITableViewController.h>
#import "Custom1TableViewCell.h"
//#import "CouldViewController.h"
#import "MJRefresh.h"
#import "Instance.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIImageView+WebCache.h"
#import "Custom.h"
int picL = 0;
@interface SquareViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _first;//用于记录是否弹出过登录框
   
}
@property (nonatomic, copy) NSMutableArray * dataSource;
@property (nonatomic, copy) NSMutableArray * dataSourceId;
@property (nonatomic, copy) NSMutableArray * dataSourcewho;
@property (nonatomic, copy) NSMutableArray * dataCrestedAt;
@property (nonatomic, copy) NSMutableArray * dataSourcezanname;
@property (nonatomic, copy) NSMutableArray * dataSourcePictures;
@property (nonatomic, copy) NSMutableArray * dataSourceComments;
@property (nonatomic, copy) NSMutableArray <UIImageView *>* pictures;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * arr1;
@property (nonatomic, strong) NSArray * arr2;
@property (nonatomic,strong) AVObject * object;
@property (nonatomic,strong) UIRefreshControl * refreshControl;
@property (nonatomic,assign) NSString *who;
@property int count;
@property (nonatomic,retain)Instance * instance;
@property (nonatomic,retain)UIImageView * imageURLArray;
@property (nonatomic,retain)NSDateFormatter * formatter;
@property (nonatomic,retain)Custom * custom;
- (void)initUserInterface;
- (void)initUserDataSouce;
- (void)barButtonPressedriji:(UIBarButtonItem *)sender;

-(void)refreshValueChanged:(UIRefreshControl *)sender;
-(void)endRefreshControl:(UIRefreshControl *)sender;
@end

@implementation SquareViewController
-(instancetype)init
{
    self = [super init];
    if (self) {
        UITabBarItem * item = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:4];
        self.tabBarItem = item;
        self.navigationItem.title = @"动态";
       
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示登录界面
//    [self showLoginView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _instance = [Instance shareInstance];
    
    [self initUserDataSouce];
    [self initUserInterface];
    [self initTableView];

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshValueChanged:)];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    _custom = [[Custom alloc]init];
    _formatter = [[NSDateFormatter alloc]init];
    _formatter.dateFormat = @"MM月dd日HH:mm";

}
//初始化tableView;
-(void)initTableView{
    CGRect frame = self.view.frame;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    //代理类
    _tableView.delegate = self;
    //数据源
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark -- custom methods
-(void)refreshValueChanged:(UIRefreshControl *)sender{
    [self performSelector:@selector(endRefreshControl) withObject:sender afterDelay:1.0];
}
-(void)endRefreshControl{
    
    [self.tableView.header endRefreshing];
    
    _dataSource = [[NSMutableArray alloc]init];
    _dataSourceId = [[NSMutableArray alloc]init];
    _dataSourcewho = [[NSMutableArray alloc]init];
    _dataCrestedAt = [[NSMutableArray alloc]init];
    
    _dataSourcezanname = [[NSMutableArray alloc]init];
    
    _dataSourcePictures = [[NSMutableArray alloc]init];
    
    _dataSourceComments = [[NSMutableArray alloc]init];
    
    AVQuery *query = [AVQuery queryWithClassName:@"Square"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //数目相同 无修改 更新不用
        NSLog(@"ççççççç√√√√√√√√√√_instance.flagadd= %d, _count = %d,objects.count = %lu", _instance.flagadd,_count, (unsigned long)objects.count);
//        if ((_count == objects.count && _instance.flagadd != 1)) {
//            NSLog(@"不刷新\n不刷新\n不刷新\n不刷新\n不刷新\n");
//            return ;
//        }
        for (int i = 0; i < objects.count; i ++) {
            _object = objects[i];
            NSString *str = [_object objectForKey:@"chat1"];
            NSString *whoload = [_object objectForKey:@"Who"];
            NSDate *createdDate = [_object objectForKey:@"createdAt"];
            NSString * createdAt = [_formatter stringFromDate:createdDate];
            createdAt = [_custom dateDeleteFirstZero:createdAt];
            NSString *idid = _object.objectId;
            NSMutableArray * arr = [_object objectForKey:@"zanname"];
            NSMutableArray * arrP = [_object objectForKey:@"pictures"];
            NSMutableArray * arrC = [_object objectForKey:@"comment"];
            NSLog(@"post = %@ %@",str,_dataSource);
           
            if(str.length < 1){
                str = @"";
            }
            [_dataSource addObject:str];
            [_dataSourcewho addObject:whoload];
            [_dataCrestedAt addObject:createdAt];
            [_dataSourceId addObject:idid];
            [_dataSourcezanname addObject:arr];
            [_dataSourcePictures addObject:arrP];
            [_dataSourceComments addObject:arrC];
            
        }
        //倒序
        [self reverse];
        NSLog(@"刷新\n刷新\n刷新\n刷新\n刷新\n");
        [self.tableView reloadData];
    }];
    _count = (int)_dataSource.count;
    _instance.flagadd = 0 ;
}
-(void)initUserDataSouce{
    
    _dataSource = [[NSMutableArray alloc]init];
    _dataSourcewho = [[NSMutableArray alloc]init];
    _dataCrestedAt = [[NSMutableArray alloc]init];

    _dataSourcezanname = [[NSMutableArray alloc]init];
    _dataSourceId = [[NSMutableArray alloc]init];
    _dataSourcePictures = [[NSMutableArray alloc]init];
    _pictures = [[NSMutableArray alloc]init];
    _dataSourceComments = [[NSMutableArray alloc] init];
    
    AVQuery *query = [AVQuery queryWithClassName:@"Square"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
 
        _count = (int)objects.count;
        for (int i = 0; i < objects.count; i ++) {
            NSLog(@"%ld",objects.count);
            _object = objects[i];
            NSString * str = [_object objectForKey:@"chat1"];
            NSString * whoload = [_object objectForKey:@"Who"];
            NSDate *createdDate = [_object objectForKey:@"createdAt"];
            NSString * createdAt = [_formatter stringFromDate:createdDate];
            createdAt = [_custom dateDeleteFirstZero:createdAt];
            NSMutableArray * arr = [_object objectForKey:@"zanname"];
            NSMutableArray * arrP = [_object objectForKey:@"pictures"];
            NSMutableArray * arrC = [_object objectForKey:@"comment"];
            
            if(str.length < 1){
                str = @"";
            }
            [_dataSource addObject:str];
            [_dataSourcewho addObject:whoload];
            [_dataCrestedAt addObject:createdAt];
            [_dataSourceId addObject:_object.objectId];
            [_dataSourcezanname addObject:arr];
            [_dataSourcePictures addObject:arrP];
            [_dataSourceComments addObject:arrC];
        }
        
        [self reverse];
        [self.tableView reloadData];
    }];
    
    NSLog(@"_count is = %d",_count);
    
    _instance.flagadd = 0;
    NSLog(@"O\n0\n0\n%d",_instance.flagadd);
}
-(void)reverse{
    
    for (int i = 0; i < _dataSource.count / 2; i ++) {
        NSString * title = _dataSource[i];
        _dataSource[i] = _dataSource[_dataSource.count - 1 -i];
        _dataSource[_dataSource.count - 1 -i] = title;
        
        NSString * who = _dataSourcewho[i];
        _dataSourcewho[i] = _dataSourcewho[_dataSource.count - 1 -i];
        _dataSourcewho[_dataSource.count - 1 -i] = who;
        
        NSString * idid = _dataSourceId[i];
        _dataSourceId[i] = _dataSourceId[_dataSource.count - 1 -i];
        _dataSourceId[_dataSource.count - 1 -i] = idid;
        
        NSString * creatAt = _dataCrestedAt[i];
        _dataCrestedAt[i] = _dataCrestedAt[_dataSource.count - 1 - i];
        _dataCrestedAt[_dataSource.count - 1 - i] = creatAt;
        
        NSMutableArray * arr = _dataSourcezanname[i];
        _dataSourcezanname[i] = _dataSourcezanname[_dataSource.count - 1 -i];
        _dataSourcezanname[_dataSource.count - 1 -i] = arr;
        
        NSMutableArray * arrP = _dataSourcePictures[i];
        _dataSourcePictures[i] = _dataSourcePictures[_dataSource.count - 1 -i];
        _dataSourcePictures[_dataSource.count - 1 -i] = arrP;
        
        NSMutableArray * arrC = _dataSourceComments[i];
        _dataSourceComments[i] = _dataSourceComments[_dataSource.count - 1 -i];
        _dataSourceComments[_dataSource.count - 1 -i] = arrC;
    }
}
-(void)initUserInterface{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    [self.view addSubview:self.tableView];
    
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发表动态" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonPressedriji:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)barButtonPressedriji:(UIBarButtonItem *)sender{
    DiaryViewController * region = [[DiaryViewController alloc]init];

    [self.navigationController pushViewController:region animated:YES];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    NSLog(@"_dataSource.count = %ld",_dataSource.count);
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";

    Custom1TableViewCell * cell = [[Custom1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (cell == nil) {
        cell = [[Custom1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableArray * arrPic = self.dataSourcePictures[indexPath.section];
    int picNumber = (int)arrPic.count;
    NSString * title = self.dataSource[indexPath.section];
    [cell setIntroductionText:picNumber textLength:(int)title.length];
    
    NSDictionary * dic = @{@"title":self.dataSource[indexPath.section],
                           @"who":self.dataSourcewho[indexPath.section],
                           @"createdAt":self.dataCrestedAt[indexPath.section],
                           @"Id":self.dataSourceId[indexPath.section],
                           @"arr":self.dataSourcezanname[indexPath.section],
                           @"arrP":self.dataSourcePictures[indexPath.section],
                           @"arrC":self.dataSourceComments[indexPath.section]};
  
    NSLog(@"-------%ld",(long)indexPath.section);
    NSLog(@"+++++++%f",_tableView.center.y);
   
    
    
    cell.contentDictionary = dic;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Custom1TableViewCell *cell = (Custom1TableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
#pragma mark -- getter
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Instance * instance = [Instance shareInstance];
    ContentViewController * infotmation = [[ContentViewController alloc] init];
    infotmation.indexRow = indexPath.row;
    
    infotmation.textBlock = ^(NSString *str) {
        
    _dataSource[indexPath.row] = str;
        
        [self.tableView reloadData];
    };
    
    instance.idid = self.dataSourceId[indexPath.section];
    instance.name = self.dataSourcewho[indexPath.section];
    instance.diary = self.dataSource[indexPath.section];
    instance.array = self.dataSourcePictures[indexPath.section];
    
    infotmation.zannameS = self.dataSourcezanname[indexPath.section];
    int zansNumber = (int)infotmation.zannameS.count;
    infotmation.goodNumber.text = [NSString stringWithFormat:@"%d",zansNumber];
    
    NSMutableArray * foot = self.dataSourceComments[indexPath.section];
    int commentNumber = (int)foot.count;
    infotmation.allComments.text = [NSString stringWithFormat:@"%d",commentNumber];
    
    NSMutableArray * arr = self.dataSourcezanname[indexPath.section];
    instance.zans = [NSString stringWithFormat:@"%ld",arr.count];
    NSLog(@"第%ld个",(long)indexPath.section);
    [self.navigationController pushViewController:infotmation animated:YES];
}
-(UIImageView *)imageURLArray{
    if (!_imageURLArray) {
        _imageURLArray = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        _imageURLArray.center = CGPointMake(100, 100);
        _imageURLArray.backgroundColor = [UIColor blackColor];
        _imageURLArray.layer.masksToBounds = YES;
        
    }
    return _imageURLArray;
}

@end
