//
//  ContentViewController.h
//  UI_hot2动态时钟
//
//  Created by rimi on 16/1/25.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TextChangeBlock)(NSString *str);

@interface ContentViewController : UIViewController

@property (nonatomic,copy) TextChangeBlock textBlock;
@property NSInteger indexRow;
@property (nonatomic, retain) UILabel * goodNumber;
@property (nonatomic, retain) UILabel * allComments;
@property (nonatomic, retain) NSMutableArray * zannameS;

@end
