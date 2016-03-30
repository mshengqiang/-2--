//
//  ContentViewController.m
//  UI_hot2动态时钟
//
//  Created by rimi on 16/1/25.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import "ContentViewController.h"
#import "Instance.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Custom.h"
#import "UIImageView+WebCache.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static int textL, textY = 0;
@interface ContentViewController ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITextView * textView;
@property (nonatomic, retain) UIImageView * picture;
@property (nonatomic, retain) UIView * tempView;

@property (nonatomic, retain) UITextField * field;
@property (nonatomic, retain)Instance * instance;
@property (nonatomic, retain)NSString * string;

@property (nonatomic, retain) UIButton * goodButtons;
@property (nonatomic, retain)UIImageView * footprint;

@property (nonatomic, retain)UILabel * labelNameTime;
@property (nonatomic, retain)UILabel * commentLabel;
@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic, retain)NSMutableArray * commentArr;
@property (nonatomic,retain)NSString * fucker;
-(void)editerbarbuttonPressed:(UIBarButtonItem *)sender;
-(void)saveButtonPressed:(UIButton *)sender;
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(editerbarbuttonPressed:)];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    _instance = [Instance shareInstance];
    NSString *str = _instance.diary;
    NSString *picNumber = _instance.picN;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情";
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 130, self.view.frame.size.width - 40, 100)];
    
    //预设文本
    self.textView.text = str;
    textL = (int)str / 25;
    textY = (int)str % 25;
    if (textY != 0) {
        textL = textL + 1;
    }
    //    NSString
    //    * desc = @"Description it is  a test font, and don't become angry for which i use to do here.Now here is a very nice party from american or not!";
    //    CGSize size = [desc sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(240, 2000) lineBreakMode:UILineBreakModeWordWrap];
    //文本对齐方式
    self.textView.textAlignment = NSTextAlignmentLeft;
    //文本颜色
    self.textView.textColor = [UIColor blackColor];
    //设置字体名字和字体大小
    self.textView.font
    = [UIFont fontWithName:@"Arial" size:18.0];
    //文本框背景颜色
    self.textView.backgroundColor = [UIColor lightGrayColor];
    //边框颜色
    self.textView.layer.borderColor = [UIColor redColor].CGColor;
    //圆角
    self.textView.layer.cornerRadius = 5.0;
    self.textView.delegate = self;
    
    //修复文本框下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    //是否可拖动
    self.textView.scrollEnabled = YES;
    
    self.textView.editable = NO;
    
    [self.scrollView addSubview:self.textView];

    
    NSLog(@"_instance.picN%@",_instance.picN);
    
    UIButton * setOut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    setOut.backgroundColor = [UIColor orangeColor];
    setOut.center = CGPointMake(382, self.tempView.center.y);
    [setOut setTitle:@"发表" forState:UIControlStateNormal];
    [self.tempView addSubview:setOut];
    [setOut addTarget:self action:@selector(setOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSLog(@"_instance.picN.length = %ld",_instance.picN.length);
    _picture = [[UIImageView alloc]init];
    for (int i = 0; i < _instance.array.count; i ++) {
        UIImageView * image = [[UIImageView alloc]init];
        NSString * imageUrl = _instance.array[i];
        NSURL * urll = [NSURL URLWithString:imageUrl];
        image.frame = CGRectMake(0,0, 120, 120);
        image.center =CGPointMake(75 + 130 * (i % 3), _textView.frame.origin.y + 170 + 130 * (i / 3));
        [image sd_setImageWithURL:urll];
        
        if (i == _instance.array.count - 1) {
            _picture.frame = image.frame;
            _picture.center = image.center;
        }
        
        [self.scrollView addSubview:image];

    }
    int picnuml = (int)_instance.array.count / 3;
    int piclines = (int)_instance.array.count % 3;
    if (piclines != 0) {
        picnuml = picnuml + 1;
    }
    self.goodButtons.center = CGPointMake(50,  20 + _textView.frame.size.height + _textView.center.y + picnuml * 120);
//    if (_instance.array.count < 1) {
//        self.goodButtons.center = CGPointMake(50, _textView.frame.size.height + _textView.center.y);
//    }
    
    self.goodNumber.center = CGPointMake(140, self.goodButtons.center.y);
    
    self.footprint.center = CGPointMake(250, self.goodButtons.center.y);
    
    self.allComments.center = CGPointMake(340, self.goodButtons.center.y);
    
    [self.scrollView addSubview:self.goodButtons];
    [self.scrollView addSubview:self.goodNumber];
    [self.scrollView addSubview:self.footprint];
    [self.scrollView addSubview:self.allComments];
    
    _commentArr = [[NSMutableArray alloc]init];
    Custom * custom = [[Custom alloc]init];
    
    AVQuery * query = [AVQuery queryWithClassName:@"Square"];
    [query getObjectInBackgroundWithId:_instance.idid block:^(AVObject *object, NSError *error) {
        
        NSArray * arr = [object objectForKey:@"comment"];
        [_commentArr addObjectsFromArray:arr];
        NSString * str = [object objectForKey:@"zans"];
        NSLog(@"str is %@,arr is %@",str,arr);
        NSLog(@"Id is _instance.idid %@_commentArr = %@,_commentArr num is %ld",_instance.idid, _commentArr,_commentArr.count);
        
        for (int i = 0; i < _commentArr.count; i ++ ) {
            _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 80, 40)];
            NSString * comment = _commentArr[i];
//            int lines = (int)comment.length / 25 ;
//            
//            label.frame = [custom customLabelTextLength:comment lines:1];
            _commentLabel.center = CGPointMake(self.scrollView.center.x, self.goodButtons.center.y + self.goodButtons.frame.size.height / 2 + 20 + (_commentLabel.frame.size.height + 10) * i);
            _commentLabel.backgroundColor = [UIColor whiteColor];
            _commentLabel.text = _commentArr[i];
            
            [self.scrollView addSubview:_commentLabel];
        }
    }];
    
   
    
    //获取评论 逐条添加到 动态下方 自适应大小 改变scrollView高度
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.field];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    self.field.hidden = YES;
    
    UITextField * field2 = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.tempView.bounds.size.width - 70, self.tempView.bounds.size.height)];
    field2.center = CGPointMake(self.tempView.center.x - 30, self.tempView.center.y);
    field2.backgroundColor = [UIColor whiteColor];
    field2.placeholder = @"我想说。。。";
    field2.borderStyle = UITextBorderStyleLine;
    field2.tag = 202;
    
    [self.tempView addSubview:field2];
    
}

-(void)setOutButtonPressed:(UIButton *)sender{
    NSLog(@"发表。。。");

    UITextField * field = (UITextField *)[self.tempView viewWithTag:202];
    _string = field.text;
    NSLog(@"_string = %@",_string);
    
    if (_string.length < 1) {
        
        return;
    }
    _string = [NSString stringWithFormat:@"%@: %@",@"张世亮",_string];
    
    UILabel * labelOthers = [[UILabel alloc]initWithFrame:CGRectMake(40, _commentLabel.center.y + _commentLabel.bounds.size.height , self.view.bounds.size.width - 80, 40)];
    if (_commentArr.count < 1) {
        labelOthers.center = CGPointMake(self.view.center.x, self.goodButtons.center.y + self.goodButtons.bounds.size.height);
    }
    labelOthers.backgroundColor = [UIColor greenColor];
    labelOthers.text = _string;

    [self.scrollView addSubview:labelOthers];
    [self.field resignFirstResponder];
    [self.view reloadInputViews];
    
    AVObject * obj = [AVObject objectWithoutDataWithClassName:@"Square" objectId:_instance.idid];
    [_commentArr addObject:_string];
    NSLog(@"_commentArr is %@, %ld",_commentArr,_commentArr.count);
    [obj setObject:_commentArr forKey:@"comment"];
    [obj save];
    
}
-(void)zanButtonPressed:(UIButton *)sender{
    
    int i = [self.goodNumber.text intValue];
    _fucker = @"张世亮";
    AVObject * myzanOr = [AVObject objectWithoutDataWithClassName:@"Square" objectId:_instance.idid];
    if ([self.zannameS containsObject:_fucker]) {

        self.goodNumber.text = [NSString stringWithFormat:@"%d", i - 1];
        [self.zannameS removeObject:_fucker];
        [myzanOr setObject:self.zannameS forKey:@"zanname"];
        [myzanOr save];
        return;
    }
    if (![self.zannameS containsObject:_fucker]) {
        
        self.goodNumber.text = [NSString stringWithFormat:@"%d", i + 1];
        [self.zannameS addObject:_fucker];
        [myzanOr setObject:self.zannameS forKey:@"zanname"];
        [myzanOr save];
        return;
    }


}
#pragma mark -- getter
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            scrollView.contentSize = CGSizeMake(SCREEN_WIDTH , SCREEN_HEIGHT * 1.5);
            scrollView.backgroundColor = [UIColor whiteColor];
            //            scrollView.pagingEnabled = YES;
            scrollView.delegate = self;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = YES;
            
            scrollView;
        });
    }
    return _scrollView;
}
-(UIImageView *)picture{
    if (!_picture) {
        _picture = [[UIImageView alloc]init];
        _picture.backgroundColor = [UIColor cyanColor];
        _picture.userInteractionEnabled = YES;
    }
    return _picture;
}
-(UIButton *)goodButtons{
    if (!_goodButtons) {
        _goodButtons = ({
            UIButton * buttons = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            buttons.center = CGPointMake(50, 460);
            [buttons setBackgroundImage:[UIImage imageNamed:@"zan.jpg"] forState:UIControlStateNormal];
            
            [buttons addTarget:self action:@selector(zanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            buttons;
        });
    }
    return _goodButtons;
}
-(UILabel *)goodNumber{
    if (!_goodNumber) {
        _goodNumber = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            label.center = CGPointMake(180, 460);

            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.shadowOffset = CGSizeMake(3,3);

            label;
            
        });
    }
    return _goodNumber;
}
-(UIImageView *)footprint{
    if (!_footprint) {
        _footprint = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_footprint setImage:[UIImage imageNamed:@"jiaoya.jpg"]];
        
    }
    return _footprint;
}
-(UILabel *)allComments{
    if (!_allComments) {
        _allComments = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];

            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.shadowOffset = CGSizeMake(3,3);

            label;
            
        });
    }
    return  _allComments;
}
-(UITextField *)field{
    if (!_field) {
        _field = ({
            UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            field.center = CGPointMake(self.view.center.x, 660);
            field.backgroundColor = [UIColor whiteColor];
            field.placeholder = @"我想说。。。";
            field.borderStyle = UITextBorderStyleLine;
            field.delegate = self;
            field.inputAccessoryView = self.tempView;
            [self.view addSubview:field];
            
            field;
        });
    }
    return _field;
}
-(UIView *)tempView{
    if (!_tempView) {
        _tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        _tempView.backgroundColor = [UIColor whiteColor];
    }
    return _tempView;
}
@end
