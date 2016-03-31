//
//  Custom.m
//  UI_hot2动态时钟
//
//  Created by rimi on 16/3/22.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import "Custom.h"

@implementation Custom
//英文id UIlabel自适应大小
-(CGRect)customLabelTextLength:(NSString *)str lines:(int)lines{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//这个frame是初设的，没关系，后面还会重新设置其size。
    [label setNumberOfLines:lines];
//    label.backgroundColor = [UIColor blackColor];
//    str = @"abcdefghijklmn";
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(self.bounds.size.width / 2,self.bounds.size.height / 4, labelsize.width + str.length * 8 / 3.0 / lines, labelsize.height + (lines - 1) * 30)];
    
    
    return label.frame;
}
-(NSString *)didSelected:(BOOL)selected LabelText:(NSString *)text{
    int num = [text intValue];
    if (selected) {
        num = num + 1;
    }
    else if (!selected) {
        num = num - 1;
    }
    NSString * number = [NSString stringWithFormat:@"%d",num];
    
    return number;
}

-(NSString *)didSelectedBystring:(NSString *)selected LabelText:(NSString *)text{
    int num = [text intValue];
    if ([selected isEqualToString:@"0"]) {
        num = num + 1;
    }
    else if ([selected isEqualToString:@"1"]) {
        num = num - 1;
    }
    NSString * number = [NSString stringWithFormat:@"%d",num];
    
    return number;
}
-(NSString *)dateDeleteFirstZero:(NSString *)date{
    
    NSString * string = [date substringToIndex:1];
    if ([string isEqualToString:@"0"]) {
        
        date = [date substringFromIndex:1];
    }
    return date;
}
@end
