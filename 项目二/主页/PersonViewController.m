//
//  PersonViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/28.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "PersonViewController.h"
#import "CollectViewController.h"
#import "PublishViewController.h"
#import "supportViewController.h"
#import "ViewController.h"
#import <AVOSCloud.h>
#import "UIImageView+WebCache.h"
@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,retain)UIImageView * headImageView;
@property (nonatomic,retain)UILabel * nicknameLabel;
@property (nonatomic,retain)UITableView * tableview;
@property (nonatomic,retain)NSArray * dataSource;
@property (nonatomic,retain)UIButton * logoutButton;
@end

@implementation PersonViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        UITabBarItem * item =[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.nicknameLabel];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.logoutButton];
    [self initDataSource];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor colorWithRed:232.0 /255.0 green:233.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationItem.title = @"个人中心";
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.dataSource = @[@"个人信息",@"2221",@"设置"];
    
    NSArray * arrays = @[@"我的收藏",@"我的发表",@"赞过我的"];
    
    
    for (int i = 0; i < 3; i ++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 149, 80)];
        view.center = CGPointMake(70 + i * 150, 320);
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 80, 50);
        button.center = CGPointMake(70+ i * 140,320);
        button.tag = 100 + i;
        [button setTitle:arrays[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(button_action:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}



- (void)initDataSource
{
    AVUser * currentUSser = [AVUser currentUser];
    self.nicknameLabel.text = currentUSser[@"Nickname"];

    NSString * imageURL = currentUSser[@"URL"];
    NSURL * url = [NSURL URLWithString:imageURL];
    [self.headImageView sd_setImageWithURL:url];

   
    
}

#pragma mark -- 点击事件
- (void)button_action:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:{
            CollectViewController * collerctionview = [[CollectViewController alloc]init];
            [self.navigationController pushViewController:collerctionview animated:YES];
        }
            break;
        case 101:{
            PublishViewController * publishview = [[PublishViewController alloc]init];
            [self.navigationController pushViewController:publishview animated:YES];
        }
            break;
        case 102:{
            SupportViewController * supportview = [[SupportViewController alloc]init];
            [self.navigationController pushViewController:supportview animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}


- (void)logoutButton_action:(UIButton *)sender
{
    
    UIAlertController * alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertcontroller animated:YES completion:nil];
    [alertcontroller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AVUser logOut];
        ViewController * viewcontroller = [[ViewController alloc]init];
        
    [self presentViewController:viewcontroller animated:YES completion:nil];
        
    }]];

    [alertcontroller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];

}


#pragma marrk -- tableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdf"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdf"];
    }
    cell.textLabel.text = self.dataSource[indexPath.section];
    
    return cell;
}

#pragma mark -- getter

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        _headImageView.center = CGPointMake(self.view.center.x, 140);
        _headImageView.layer.cornerRadius = 60;
        _headImageView.backgroundColor = [UIColor orangeColor];
        _headImageView.layer.masksToBounds = YES;

        
        
    }
    return _headImageView;
}


- (UILabel *)nicknameLabel
{
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        _nicknameLabel.center = CGPointMake(self.view.center.x, 240);
        _nicknameLabel.text = @" ";
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nicknameLabel;
}


- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 370, self.view.bounds.size.width, 200)];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.rowHeight = 65;
        
    }
    return _tableview;
}

- (UIButton *)logoutButton
{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.frame = CGRectMake(0, 0, 300, 50);
        _logoutButton.center = CGPointMake(self.view.center.x, 630);
        [_logoutButton setTitle:@"注销登录" forState:UIControlStateNormal];
        _logoutButton.backgroundColor = [UIColor orangeColor];
        [_logoutButton addTarget:self action:@selector(logoutButton_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}










@end
