//
//  ViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/17.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "RetrievePasswordViewController.h"
#import "HomeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface ViewController ()

@property (nonatomic,retain)UITextField * userNameText;
@property (nonatomic,retain)UITextField * passwordText;
@property (nonatomic,retain)UIButton * loginButton;
@property (nonatomic,retain)UIButton * registerButton;
@property (nonatomic,retain)UIButton * forgetPasswordButton;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUserInterface];
    [self.view addSubview:self.userNameText];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.forgetPasswordButton];
    
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"背景"];
    [self.view addSubview:imageview];
}




#pragma mark -- 点击事件

- (void)loginButton_action:(UIButton *)sender
{
    [AVUser logInWithUsernameInBackground:self.userNameText.text password:self.passwordText.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            UIAlertController * alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"登陆成功"preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertcontroller animated:YES completion:nil];
            [self performSelector:@selector(dissmissAlertController:) withObject:alertcontroller afterDelay:1.0];
            [self performSelector:@selector(persentHomeview) withObject:alertcontroller afterDelay:1.0];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAutoLogin"];

        }
        if (error) {
            UIAlertController * alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertcontroller animated:YES completion:nil];
            [alertcontroller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            }]];

        }
    }];

}


- (void)registerButton_action:(UIButton *)sender
{
    RegisterViewController * registerView = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (void)forgetPasswordButton_action:(UIButton *)sender
{
    RetrievePasswordViewController * retrieveView = [[RetrievePasswordViewController alloc]init];
    
    [self.navigationController pushViewController:retrieveView animated:YES];
}

#pragma mark -- 方法

- (void)persentHomeview
{
    HomeViewController * homeview = [[HomeViewController alloc]init];
    
    [self presentViewController:homeview animated:YES completion:nil];
}



-(void)dissmissAlertController:(UIAlertController *)alercomtrollrer
{
    [alercomtrollrer dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- getter

- (UITextField *)userNameText
{
    if (!_userNameText) {
        _userNameText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
        _userNameText.center = CGPointMake(self.view.center.x, 300);
        _userNameText.borderStyle = UITextBorderStyleBezel;
        _userNameText.placeholder = @"请输入账号或手机号";
        _userNameText.clearButtonMode = UITextFieldViewModeAlways;
        
        
    }
    return _userNameText;
}

- (UITextField *)passwordText
{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
        _passwordText.center = CGPointMake(self.view.center.x, 350);
        _passwordText.borderStyle = UITextBorderStyleBezel;
        _passwordText.placeholder = @"请输入密码";
        _passwordText.clearButtonMode = UITextFieldViewModeAlways;
        _passwordText.secureTextEntry = YES;
    }
    return _passwordText;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(0, 0, 250, 40);
        _loginButton.center = CGPointMake(self.view.center.x, 550);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor lightGrayColor];
        [_loginButton addTarget:self action:@selector(loginButton_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}


- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame = CGRectMake(0, 0, 100, 40);
        _registerButton.center = CGPointMake(120, 420);
        [_registerButton setTitle:@"还没注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButton_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)forgetPasswordButton
{
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetPasswordButton.frame = CGRectMake(0, 0, 100, 40);
        _forgetPasswordButton.center = CGPointMake(120, 460);
        [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordButton_action:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _forgetPasswordButton;
}



@end
