//
//  HomePageViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/28.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "HomePageViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UIScrollView * scrollview;
@property (nonatomic,retain)UITableView * tableview;
@property (nonatomic,retain)NSArray * lyricsArray;


@end

@implementation HomePageViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        UITabBarItem * item =[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.tableview];
    [self initDataSource];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"主页";
    
    NSArray * nameArray = @[@"歌词",@"情感",@"励志",@"笑话",@"语录",@"正能量"];
    for (int i = 0 ; i < 6; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 70, 70);
        button.center = CGPointMake(60 + i * 80, 30);
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [self.scrollview addSubview:button];
        [button addTarget:self action:@selector(button_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)initDataSource
{
    self.lyricsArray = @[@"1",@"2"];
}



#pragma mark -- 

- (void)button_action:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:{
            [self.view addSubview:self.tableview];
        }
            break;
        case 101:{
            [self.tableview removeFromSuperview];
            
        }
            break;
        case 102:{
            
        }
        case 103:{
            
        }
            break;
        case 104:{
            
        }
            break;
        case 105:{
            
        }
            break;
        default:
            break;
    }
}






#pragma mark --UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lyricsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdf"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdf"];
    }
    cell.textLabel.text = self.lyricsArray[indexPath.row];
    
    return cell;
}
#pragma mark -- getter

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,CGRectGetWidth(self.view.bounds), 60)];
        _scrollview.contentSize = CGSizeMake(600, 60);
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.pagingEnabled = YES;
        _scrollview.bounces = NO;
        _scrollview.showsHorizontalScrollIndicator = YES;
        _scrollview.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollview;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 50;
        
    }
    return _tableview;
}

@end
