//
//  HomeView.m
//  项目二
//
//  Created by rimi on 16/3/31.
//  Copyright © 2016年 吴喜超. All rights reserved.
//

#import "HomeView.h"
@interface HomeView()
@property(nonatomic,retain)NSArray * titleArray;

@property(nonatomic,retain)UIImageView * userView;
@property(nonatomic,retain)UILabel * userName;
@property(nonatomic,retain)UILabel * date;

@property(nonatomic,retain)NSString * title;
@property(nonatomic,retain)NSArray<UIImageView *> * pictures;

@property(nonatomic,retain)UIButton * zanButton;
@property(nonatomic,retain)UILabel * zansLabel;
@property(nonatomic,retain)UILabel * footPrint;
@property(nonatomic,retain)UIImageView * footImage;
@end
@implementation HomeView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame ];
    if (self) {
        
        self.userName.text = title;
        [self initalizeInterface];
    }
    return self;
}
-(void)initalizeInterface{
    
    self.userView.center = CGPointMake(50, 50);
    [self addSubview:self.userView];
    
    self.userName.center = CGPointMake(250, 50);
    [self addSubview:self.userName];
    
    self.layer.backgroundColor = [UIColor purpleColor].CGColor;
    self.layer.cornerRadius = 10;
    self.frame = CGRectMake(0, 0, 300, 500);
    self.center = CGPointMake(207, 400);
    
}
#pragma mark -- Getter
-(UIImageView *)userView{
    if (!_userView) {
        _userView = ({
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
            imageView.backgroundColor = [UIColor blackColor];
            
            imageView;
        });
    }
    return _userView;
}
-(UILabel *)userName{
    if (!_userName) {
        _userName = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
            
            label;
        });
    }
    return _userName;
}
@end
