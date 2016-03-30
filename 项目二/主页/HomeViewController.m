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
    

    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    homeoageView.navigationBar.titleTextAttributes = dict;
    personView.navigationBar.titleTextAttributes = dict;
    squareView.navigationBar.titleTextAttributes = dict;
    
    homeoageView.navigationBar.barTintColor = [[UIColor alloc] initWithRed:26 / 255.0 green:121 / 255.0 blue:252 / 255.0 alpha:1];
    personView.navigationBar.barTintColor = squareView.navigationBar.barTintColor = homeoageView.navigationBar.barTintColor;
    
    self.viewControllers = @[homeoageView,squareView,personView];
    
    
    
}



@end
