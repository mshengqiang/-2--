//
//  ChangePasswordViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/18.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface ChangePasswordViewController ()

@property (nonatomic,retain)UITextField * passwordtext;
@property (nonatomic,retain)UIButton * finishbutton;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
    [self.view addSubview:self.passwordtext];
    [self.view addSubview:self.finishbutton];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor colorWithRed:232.0 /255.0 green:233.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 430, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 18, 60, 60);
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button_action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 50)];
    titleLable.center = CGPointMake(view.center.x, 50);
    titleLable.text = @"修改密码";
    titleLable.font = [UIFont systemFontOfSize:24];
    titleLable.tintColor = [UIColor blackColor];
    [self.view addSubview:titleLable];
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 60)];
    view1.center = CGPointMake(self.view.center.x, 140);
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    label.center = CGPointMake(80, 140);
    label.text = @"密码:";
    label.tintColor = [UIColor blackColor];
    [self.view addSubview:label];
    

    
}
#pragma mark --
- (void)button_action:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)finishbutton_action:(UIButton *)sender
{
    [AVUser resetPasswordWithSmsCode:self.smsCode newPassword:self.passwordtext.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtrollrer animated:YES completion:nil];
            [self performSelector:@selector(dissmissAlertController:) withObject:alercomtrollrer afterDelay:1.0];
        }
        if (error) {
            UIAlertController * alercomtroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtroller animated:YES completion:nil];
            [alercomtroller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];

        }
    }];
}



#pragma mark -- 方法

-(void)dissmissAlertController:(UIAlertController *)alercomtrollrer
{
    [alercomtrollrer dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- getter

- (UITextField *)passwordtext
{
    if (!_passwordtext) {
        _passwordtext = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        _passwordtext.center = CGPointMake(self.view.center.x, 140);
        _passwordtext.borderStyle = UITextBorderStyleNone;
        _passwordtext.placeholder = @"请输入要修改后的密码";
        _passwordtext.secureTextEntry = YES;

    }
    return _passwordtext;
}


- (UIButton *)finishbutton
{
    if (!_finishbutton) {
        _finishbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishbutton.frame = CGRectMake(0, 0, 300, 50);
        _finishbutton.center = CGPointMake(self.view.center.x, 350);
        [_finishbutton setTitle:@"完成修改" forState:UIControlStateNormal];
        _finishbutton.backgroundColor = [UIColor orangeColor];
        [_finishbutton addTarget:self action:@selector(finishbutton_action:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _finishbutton;
}







@end
