//
//  Custom1TableViewCell.h
//  UI_hot2动态时钟
//
//  Created by rimi on 16/1/21.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Custom1TableViewCell : UITableViewCell
@property (nonatomic,strong)NSDictionary * contentDictionary;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier numberOfTextView:(int)num numberOfPictures:(int)numbOfP zans:(NSNumber *)zans;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier numberOfTextView:(int)num;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setIntroductionText;
-(void)setIntroductionText:(int)pictureNum textLength:(int)textLength;
@end
