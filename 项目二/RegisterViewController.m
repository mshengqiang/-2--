//
//  RegisterViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/17.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserInterfaceViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface RegisterViewController ()

@property (nonatomic,retain)UITextField * phoneText;
@property (nonatomic,retain)UITextField * passwordText;
@property (nonatomic,retain)UITextField * codeText;
@property (nonatomic,retain)UIButton * getCodeButton;
@property (nonatomic,retain)UIButton * nextButton;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.getCodeButton];
    [self.view addSubview:self.nextButton];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor colorWithRed:232.0 /255.0 green:233.0/255.0 blue:232.0/255.0 alpha:1.0];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 430, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
  
    UIButton * goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame = CGRectMake(10, 18, 60, 60);
    [goButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(gobutton_action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goButton];
    
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 50)];
    titleLable.center = CGPointMake(view.center.x, 50);
    titleLable.text = @"注册(1/2)";
    titleLable.font = [UIFont systemFontOfSize:24];
    titleLable.tintColor = [UIColor blackColor];
    [self.view addSubview:titleLable];
    
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 110)];
    view1.center = CGPointMake(self.view.center.x, 170);
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 2)];
    view2.center = view1.center;
    view2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view2];
    
    
    UIView * view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 60)];
    view3.center = CGPointMake(self.view.center.x, 280);
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, 100, 50)];
    label.text = @"手机号:";
    label.tintColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 170, 100, 50)];
    label1.text = @"验证码:";
    label1.tintColor = [UIColor blackColor];
    [self.view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    label2.center = CGPointMake(80, 280);
    label2.text = @"密码:";
    label2.tintColor = [UIColor blackColor];
    [self.view addSubview:label2];
    
    
}




#pragma mark -- 点击事件

- (void)gobutton_action:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getCodeButton_action:(UIButton *)sender
{
    [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneText.text callback:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取验证码成功，十分钟内有效" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtrollrer animated:YES completion:nil];
            [self performSelector:@selector(dissmissAlertController:) withObject:alercomtrollrer afterDelay:1.0];
        }
        if (error) {
//            NSLog(@"%@",error);
            UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号或验证码有错误" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtrollrer animated:YES completion:nil];
            
            [alercomtrollrer addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            
        }
        
    }];
}

- (void)nextButton_action:(UIButton *)sender
{
    [self pushImportView];
    
    //判断手机号
    NSString * phoneString = self.phoneText.text;
    if (phoneString.length != 11) {
        UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号输入错误" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alercomtrollrer animated:YES completion:nil];
        [self performSelector:@selector(dissmissAlertController:) withObject:alercomtrollrer afterDelay:1.0];
        return;

    }
    //判断验证码
    NSString * codeString = self.codeText.text;
    if (codeString.length != 6) {
        UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码输入错误" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alercomtrollrer animated:YES completion:nil];
        [self performSelector:@selector(dissmissAlertController:) withObject:alercomtrollrer afterDelay:1.0];
        return;
    }
    
    //验证短信
    [AVUser verifyMobilePhone:codeString withBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
        
    }];
    
    
    //注册
    AVUser * user =[AVUser user];
    user.mobilePhoneNumber = self.phoneText.text;
    user.password = self.passwordText.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController * alercomtrollrer = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtrollrer animated:YES completion:nil];
            [self performSelector:@selector(dissmissAlertController:) withObject:alercomtrollrer afterDelay:1.0];
//            [self pushImportView];
        }
        if (error) {
            NSLog(@"%@",error.localizedDescription);
            UIAlertController * alercomtroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号被注册" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alercomtroller animated:YES completion:nil];
            [alercomtroller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }]];
           
        }
    }];
    
    
}


#pragma mark -- 方法
//跳转下个界面
- (void)pushImportView
{
    UserInterfaceViewController * userinteface = [[UserInterfaceViewController alloc]init];
    
    [self.navigationController pushViewController:userinteface animated:YES];
}

-(void)dissmissAlertController:(UIAlertController *)alercomtrollrer
{
    [alercomtrollrer dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- getter

- (UITextField *)phoneText
{
    if (!_phoneText) {
        _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        _phoneText.center = CGPointMake(self.view.center.x, 145);
        _phoneText.borderStyle = UITextBorderStyleNone;
        _phoneText.placeholder  = @"请输入11位手机号";
    }
    return _phoneText;
}

- (UITextField *)passwordText
{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        _passwordText.center = CGPointMake(self.view.center.x, 280);
        _passwordText.borderStyle = UITextBorderStyleNone;
        _passwordText.placeholder = @"请输入2-20位数字或字母";
        
    }
    return _passwordText;
}




- (UITextField *)codeText
{
    if (!_codeText) {
        _codeText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        _codeText.center = CGPointMake(self.view.center.x, 195);
        _codeText.borderStyle  = UITextBorderStyleNone;
        _codeText.placeholder = @"请输入验证码";
    }
    return _codeText;
}

- (UIButton *)getCodeButton
{
    if (!_getCodeButton) {
        _getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeButton.frame = CGRectMake(0, 0, 120, 60);
        _getCodeButton.center = CGPointMake(330, 195);
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_getCodeButton addTarget:self action:@selector(getCodeButton_action:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _getCodeButton;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(0, 0, 300, 50);
        _nextButton.center = CGPointMake(self.view.center.x, 370);
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.backgroundColor = [UIColor orangeColor];
        [_nextButton addTarget:self action:@selector(nextButton_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}


@end
