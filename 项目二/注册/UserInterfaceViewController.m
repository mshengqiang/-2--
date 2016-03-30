//
//  UserInterfaceViewController.m
//  项目二
//
//  Created by 吴喜超 on 16/3/17.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "UserInterfaceViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ViewController.h"
@interface UserInterfaceViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,retain)UIButton *  headButton;
@property (nonatomic,retain)UITextField * nickNameText;
@property (nonatomic,retain)UIButton * finishButton;
@property (nonatomic,retain)UIImage * image;
@property (nonatomic,retain)NSString * imageName;
@property (nonatomic,retain)NSString * urlString;
@end

@implementation UserInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUserInterface];
    [self.view addSubview:self.headButton];
    [self.view addSubview:self.nickNameText];
    [self.view addSubview:self.finishButton];
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
    titleLable.text = @"注册(2/2)";
    titleLable.font = [UIFont systemFontOfSize:24];
    titleLable.tintColor = [UIColor blackColor];
    [self.view addSubview:titleLable];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 40)];
    label.center = CGPointMake(self.view.center.x, 230);
    label.text = @"点击设置头像";
    label.tintColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 50)];
    view1.center = CGPointMake(self.view.center.x, 330);
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
}

#pragma mark -- 点击事件
- (void)button_action:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置头像
- (void)headButton_action:(UIButton *)sender
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    //打开相机
    UIAlertAction * comeraction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takecamera];
        
    }];
    UIAlertAction * photoaction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takephoto];
        
    }];
    
    UIAlertAction * canceaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:comeraction];
    [alert addAction:photoaction];
    [alert addAction:canceaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


//完成按钮
- (void)finishButton_action:(UIButton *)sender
{
    
    //保存昵称
    AVUser * currentUser = [AVUser currentUser];
    [currentUser setObject:self.urlString forKey:@"URL"];
    [currentUser setObject:self.nickNameText.text forKey:@"Nickname"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.nickNameText forKey:@"userName"];
    
    //保存头像 
    NSData * imagedata = UIImageJPEGRepresentation(self.image, 0.6);
    AVFile * file = [AVFile fileWithName:@"image" data:imagedata];
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            self.urlString = file.url;
            AVUser * currentUser = [AVUser currentUser];
            [currentUser setObject:self.urlString forKey:@"URL"];
            [currentUser save];
            
            [self finishSuccess];
        }
        if (error) {
            [self finishFailure];
        }
    }];

}




#pragma mark -- 方法
//调用相机
- (void)takecamera
{
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备不支持相机" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dissmissAlertController:) withObject:alert afterDelay:1.0];
        
        return;
    }
    UIImagePickerController * piceker = [[UIImagePickerController alloc]init];
    //数据源
    piceker.sourceType = UIImagePickerControllerSourceTypeCamera;
    piceker.allowsEditing = YES;
    [self presentViewController:piceker animated:YES completion:nil];
}

//调用相册
- (void)takephoto
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    //数据源
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

//调用相册保存头像的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self.headButton setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    
    //保存头像
    self.image = info[UIImagePickerControllerEditedImage];
    
    

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishSuccess
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    [self performSelector:@selector(dissmissAlertController:) withObject:alert afterDelay:1.0];
    [self performSelector:@selector(personViewController) withObject:alert afterDelay:1.0];
}

- (void)finishFailure
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    [self performSelector:@selector(dissmissAlertController:) withObject:alert afterDelay:1.0];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];


}




- (void)personViewController
{
    ViewController * viewcontroller = [[ViewController alloc]init];
    
    [self presentViewController:viewcontroller animated:YES completion:nil];
}

//弹出框消失
-(void)dissmissAlertController:(UIAlertController *)alercomtrollrer
{
    [alercomtrollrer dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- getter

- (UIButton *)headButton
{
    if (!_headButton) {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.frame = CGRectMake(0, 0, 100, 100);
        _headButton.center = CGPointMake(self.view.center.x - 10, 150);
        [_headButton setImage:[UIImage imageNamed:@"头像选择"] forState:UIControlStateNormal];
        _headButton.layer.cornerRadius = 50;
        _headButton.layer.masksToBounds = YES;
        [_headButton addTarget:self action:@selector(headButton_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headButton;
}

- (UITextField *)nickNameText
{
    if (!_nickNameText) {
        _nickNameText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        _nickNameText.center = CGPointMake(self.view.center.x, 330);
        _nickNameText.borderStyle = UITextBorderStyleNone;
        _nickNameText.placeholder = @"请输入昵称";
        _nickNameText.textAlignment = NSTextAlignmentCenter;
    }
    return _nickNameText;
}

- (UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        _finishButton.center = CGPointMake(self.view.center.x, 420);
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        _finishButton.backgroundColor = [UIColor orangeColor];
        [_finishButton addTarget:self action:@selector(finishButton_action:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _finishButton;
}


@end
