//
//  CustomTableViewCell.m
//  UI_hot2动态时钟
//
//  Created by rimi on 16/1/19.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import "Custom1TableViewCell.h"
#import "Custom.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIImageView+WebCache.h"
#define COLOR_RGB(R, G, B) [UIColor colorWithRed:((R) / 255.0) green:((G) / 255.0) blue:((B) / 255.0) alpha:1]
int hang, textL, textY, pictL, pictY ,goodN, zanint = 0;
@interface Custom1TableViewCell ()
@property (nonatomic,strong) UIView * shadowView;

@property (nonatomic, strong) UILabel * datetitle;
@property (nonatomic, strong) UIImageView * avatar;
@property (nonatomic, strong) UITextView * saysay;
@property (nonatomic, assign) NSInteger textLength;

@property (nonatomic, retain) UIImageView * picture;
@property (nonatomic,retain)AVObject * object;
@property (nonatomic, retain) UIButton * goodLike;
@property (nonatomic, retain)UIImageView * footprint;
@property (nonatomic, retain) UILabel * goodNumber;
@property (nonatomic, retain) UILabel * allComments;

@property (nonatomic, retain) UILabel * name;
@property (nonatomic, retain) Custom * custom;

@property (nonatomic,copy)NSString * zansSum;
@property (nonatomic,copy)NSString * cellId;

@property (nonatomic,retain)NSMutableArray * array;
@property (nonatomic,retain)NSMutableArray * arrayPictures;
@property (nonatomic,retain)NSMutableArray * arrayComments;
@property (nonatomic,retain)NSString * fuck;


@property (nonatomic,retain)CAGradientLayer * gradientLayer;
@end
@implementation Custom1TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self initUerInterface];
    }
    return self;
}

-(void)initUerInterface
{

//    self.gradientLayer.frame = self.contentView.frame;
    [self.contentView.layer addSublayer:self.gradientLayer];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.saysay];
    [self.contentView addSubview:self.datetitle];
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.goodLike];
    [self.contentView addSubview:self.goodNumber];
    [self.contentView addSubview:self.footprint];
    [self.contentView addSubview:self.allComments];
    
}
#pragma mark -- animation
- (CABasicAnimation *)gradientAnimationWithColors:(NSArray *)colors {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 0.8;
    animation.toValue =  colors;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}
// 自适应 大小
-(void)exchange{
    
    textL = (int)_textLength / 25;
    textY = (int)_textLength % 25;
    if (textY != 0) {
        textL = textL + 1;
    }
    
    self.name.frame = CGRectMake(60, 5, 100, 40);
    Custom * cus = [[Custom alloc]init];
    CGPoint point = self.name.center;
    self.name.frame = [cus customLabelTextLength:self.name.text lines:1];
    self.name.center = point;
    self.datetitle.frame = CGRectMake(260, 5, 150, 40);
    self.avatar.frame = CGRectMake(10, 10, 35, 35);
    self.saysay.frame = CGRectMake(10, 50, 390, 30 * textL);//文本
    
    _picture = [[UIImageView alloc]init];
    for (int i = 0 ; i < _arrayPictures.count; i ++) {
        
        UIImageView * image = [[UIImageView alloc]init];
        NSString * imageUrl = _arrayPictures[i];
        NSURL * urll = [NSURL URLWithString:imageUrl];
        image.frame = CGRectMake(15 + 130 * (i % 3), 30 * textL + 70 + 130 * (i / 3), 120, 120);
        image.backgroundColor = [UIColor redColor];
        [image sd_setImageWithURL:urll];
        [self.contentView addSubview:image];
        
    }
    pictL = (int)_arrayPictures.count / 3;
    pictY = (int)_arrayPictures.count % 3;
    if (pictY != 0 ) {
        pictL = pictL + 1;
    }
    self.goodLike.frame = CGRectMake(10,textL * 30 + 140 * pictL + 80, 40, 40);
    
    self.goodNumber.frame = CGRectMake(100, textL * 30 + 140 * pictL + 80, 40, 40);
    
    self.footprint.frame = CGRectMake(210, textL * 30 + 140 * pictL + 80, 40, 40);
    
    self.allComments.frame = CGRectMake(300, textL * 30 + 140 * pictL + 80, 40, 40);
    
    self.gradientLayer.frame = CGRectMake(0, 0, 414,self.goodLike.center.y + self.goodLike.frame.size.height);
    
}

#pragma mark -- setter

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(int)pictureNum textLength:(int)textLength{
    //获得当前cell高度
    CGRect frame = [self frame];
    
    textL = textLength / 25;
    textY = textLength % 25;
    if (textY != 0) {
        textL = textL + 1;
    }
    
    int zheng = pictureNum / 3;
    int ling = pictureNum % 3;
    if (ling != 0 ) {
        zheng = zheng + 1;
    }
    
    //计算出自适应的高度
    frame.size.width = 414;
    frame.size.height = 140 * zheng + textL * 30 + 140;
 
    self.frame = frame;
}
//数据 来了
-(void)setContentDictionary:(NSDictionary *)contentDictionary{
    _fuck = @"张世亮";
    _contentDictionary = contentDictionary;
    
    _cellId = _contentDictionary[@"Id"];
    
    self.saysay.text = _contentDictionary[@"title"];
    _textLength = self.saysay.text.length;
    NSLog(@"\n\n\n=%@%ld",self.saysay.text,_textLength);
    
    _array = _contentDictionary[@"arr"];
    zanint = (int)_array.count;
    
    if ([_array containsObject:_fuck]) {
        self.datetitle.text = @"1";
    }else if (![_array containsObject:_fuck]){
        self.datetitle.text = @"0";
    }

    _arrayPictures = _contentDictionary[@"arrP"];
    _arrayComments = _contentDictionary[@"arrC"];
    int foot = (int)_arrayComments.count;
    NSString * foots = [NSString stringWithFormat:@"%d",foot];
    self.allComments.text = foots;
    
    self.name.text = _contentDictionary[@"who"];
    
    NSLog(@"1111wo jiu fuck le %d",zanint);
    _zansSum = [NSString stringWithFormat:@"%d",zanint];
    self.goodNumber.text = _zansSum;
    
    [self exchange];
}
#pragma mark -- zans and zanOr
-(void)goodLikePressed:(UIButton *)sender{

    AVObject * myzanOr = [AVObject objectWithoutDataWithClassName:@"Square" objectId:_cellId];
    NSLog(@"2222wo jiu fuck le %d",zanint);
    if ([_array containsObject:_fuck]) {
        self.datetitle.text = @"0";
        [_array removeObject:_fuck];
        self.goodNumber.text = [NSString stringWithFormat:@"%d", zanint - 1];
 
        [myzanOr setObject:_array forKey:@"zanname"];
        
        [myzanOr save];
        return;
    }
    if(![_array containsObject:_fuck]){
        self.datetitle.text = @"1";
        [_array addObject:_fuck];
        self.goodNumber.text = [NSString stringWithFormat:@"%d", zanint + 1];
 
        [myzanOr setObject:_array forKey:@"zanname"];
     
        [myzanOr save];
        return;
    }
    

    [self reloadInputViews];

}


#pragma mark -- getter
-(UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        [_avatar setImage:[UIImage imageNamed:@"2.jpg"]];
        _avatar.layer.cornerRadius = 18;
//        _avatar.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _avatar;
}
//-(UIImageView *)picture{
//    if (!_picture) {
//        _picture = [[UIImageView alloc]init];
//        _picture.backgroundColor = [UIColor cyanColor];
//        _picture.userInteractionEnabled = YES;
//    }
//    return _picture;
//}
- (UILabel *)name{
    if (!_name) {
        _name = ({
            UILabel * label = [[UILabel alloc]init];
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor greenColor];
            label.textAlignment = NSTextAlignmentLeft;
//            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.shadowOffset = CGSizeMake(3,3);
            label.enabled = NO;
            label;
            
        });
    }
    return _name;
}
- (UILabel *)datetitle{
    if (!_datetitle) {
        _datetitle = ({
            UILabel * label = [[UILabel alloc]init];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont fontWithName:@"Arial" size:17];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.shadowOffset = CGSizeMake(3,3);
            label.enabled = NO;
            label;
            
        });
    }
    return _datetitle;
}
-(UITextView *)saysay{
    if (!_saysay) {
        _saysay = [[UITextView alloc]init];
        _saysay.backgroundColor = [UIColor greenColor];
        _saysay.textAlignment = NSTextAlignmentLeft;
        _saysay.font = [UIFont fontWithName:@"Arial" size:16];
        _saysay.scrollEnabled = NO;
        _saysay.editable = NO;
//        _saysay.backgroundColor = [UIColor lightGrayColor];
    }
    return _saysay;
}
-(UIButton *)goodLike{
    if (!_goodLike) {
        _goodLike = [UIButton buttonWithType:UIButtonTypeSystem];
        [_goodLike setBackgroundImage:[UIImage imageNamed:@"zan.jpg"] forState:UIControlStateNormal];
        [_goodLike addTarget:self action:@selector(goodLikePressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodLike;
}
-(UIImageView *)footprint{
    if (!_footprint) {
        _footprint = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_footprint setImage:[UIImage imageNamed:@"jiaoya.jpg"]];
        
    }
    return _footprint;
}
-(UILabel *)goodNumber{
    if (!_goodNumber) {
        _goodNumber = ({
            UILabel * label = [[UILabel alloc]init];
            label.text = _zansSum;// 云中取
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.shadowOffset = CGSizeMake(3,3);
            label.enabled = NO;
            label;
            
        });
    }
        return _goodNumber;
}
-(UILabel *)allComments{
    if (!_allComments) {
        _allComments = ({
            UILabel * label = [[UILabel alloc]init];
//            label.text = _zansSum;// 云中取
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.shadowOffset = CGSizeMake(3,3);
            label.enabled = NO;
            label;
            
        });
    }
    return  _allComments;
}
-(Custom *)custom{
    if (!_custom) {
        _custom = [[Custom alloc]init];
    }
    return _custom;
}

-(CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(0, 0, self.layer.frame.size.width,200);
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:191 green:77 blue:196 alpha:1].CGColor,(__bridge id)[UIColor cyanColor].CGColor];
        _gradientLayer.locations = @[@0.5,@1];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 1);
    }
    return _gradientLayer;
}
@end
