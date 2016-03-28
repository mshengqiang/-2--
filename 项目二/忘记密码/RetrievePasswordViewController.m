//
//  RetrievePasswordViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/18.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface RetrievePasswordViewController ()

@property (nonatomic,retain)UITextField * phonetext;
@property (nonatomic,retain)UITextField * codetext;
@property (nonatomic,retain)UIButton * nextbutton;

@end

@implementation RetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
    [self.view addSubview:self.phonetext];
    [self.view addSubview:self.codetext];
    [self.view addSubview:self.nextbutton];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor colorWithRed:232.0 /255.0 green:233.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 430, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 110)];
    view1.center = CGPointMake(self.view.center.x, 170);
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 2)];
    view2.center = view1.center;
    view2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view2];
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 18, 60, 60);
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button_action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 50)];
    titleLable.center = CGPointMake(view.center.x, 50);
    titleLable.text = @"找回密码";
    titleLable.font = [UIFont systemFontOfSize:24];
    titleLable.tintColor = [UIColor blackColor];
    [self.view addSubview:titleLable];
    
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, 100, 50)];
    label.text = @"账号:";
    label.tintColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 170, 100, 50)];
    label1.text = @"邮箱:";
    label1.tintColor = [UIColor blackColor];
    [self.view addSubview:label1];
    

}

#pragma mark -- 点击事件

- (void)button_action:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)nextbutton_action:(UIButton *)sender
{
    [AVUser requestPasswordResetForEmailInBackground:self.codetext.text block:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:@"邮件已发送,请查看邮箱" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtrollrer animated:YES completion:nil];
            [self performSelector:@selector(dissmissAlertController:) withObject:alercomtrollrer afterDelay:1.0];
        }
        if (error) {
            UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtrollrer animated:YES completion:nil];
            [alercomtrollrer addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
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

- (UITextField *)phonetext
{
    if (!_phonetext) {
        _phonetext = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        _phonetext.center = CGPointMake(self.view.center.x, 145);
        _phonetext.borderStyle = UITextBorderStyleNone;
        _phonetext.placeholder  = @"请输入用户名账号";

    }
    return _phonetext;
}

- (UITextField *)codetext
{
    if (!_codetext) {
        _codetext = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        _codetext.center = CGPointMake(self.view.center.x, 195);
        _codetext.borderStyle  = UITextBorderStyleNone;
        _codetext.placeholder = @"请注册时的邮箱";

    }
    return _codetext;
}


- (UIButton *)nextbutton
{
    if (!_nextbutton) {
        _nextbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextbutton.frame = CGRectMake(0, 0, 300, 50);
        _nextbutton.center = CGPointMake(self.view.center.x, 350);
        [_nextbutton setTitle:@"完成修改" forState:UIControlStateNormal];
        _nextbutton.backgroundColor = [UIColor orangeColor];
        [_nextbutton addTarget:self action:@selector(nextbutton_action:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _nextbutton;
}




@end
