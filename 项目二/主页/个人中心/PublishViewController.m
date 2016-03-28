//
//  PublishViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/28.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()

@property (nonatomic,retain)UITableView * tableview;
@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterfcae];
}

- (void)initUserInterfcae
{
    self.view.backgroundColor = [UIColor colorWithRed:232.0 /255.0 green:233.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationItem.title = @"我的发表";
}



#pragma mark -- getter

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
    }
    return _tableview;
}



@end
