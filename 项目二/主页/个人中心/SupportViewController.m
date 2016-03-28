//
//  SupportViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/28.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor colorWithRed:232.0 /255.0 green:233.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationItem.title = @"赞过我的";
}

@end
