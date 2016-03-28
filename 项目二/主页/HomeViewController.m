//
//  HomeViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/25.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "HomeViewController.h"
#import "HomePageViewController.h"
#import "PersonViewController.h"
#import "SquareViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UINavigationController * homeoageView = [[UINavigationController alloc]initWithRootViewController:[[HomePageViewController alloc]init]];
    
    UINavigationController * personView = [[UINavigationController alloc]initWithRootViewController:[[PersonViewController alloc]init]];
    UINavigationController * squareView = [[UINavigationController alloc]initWithRootViewController:[[SquareViewController alloc]init]];
    

    self.viewControllers = @[homeoageView,squareView,personView];
    
}



@end
