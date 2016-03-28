//
//  SquareViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/28.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "SquareViewController.h"

@interface SquareViewController ()

@end

@implementation SquareViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITabBarItem * item =[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:2];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
}
- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor greenColor];
}

@end
