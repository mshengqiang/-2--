//
//  DiaryViewController.h
//  UI_hot2动态时钟
//
//  Created by rimi on 16/1/20.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TextBlock)(NSString *str);
typedef void(^dateTextBlock) (NSString * date);
typedef void (^ColorBlock) (UIColor* color);

typedef void(^TitleBlock) (NSString * date);
typedef void(^PicBlock) (NSString * date);
typedef void(^WhoTextBlock) (NSString * date);
typedef void(^IdTextBlock) (NSString * date);


@interface DiaryViewController : UIViewController

@property (nonatomic,copy) ColorBlock colorBlock;
@property (nonatomic,copy) TextBlock textBlock;
@property (nonatomic,copy) dateTextBlock datetextBlock;

@property (nonatomic,copy) TitleBlock titleBlock;
@property (nonatomic,copy) PicBlock picBlock;
@property (nonatomic,copy) WhoTextBlock whoBlock;
@property (nonatomic,copy) IdTextBlock idBlock;


@end
