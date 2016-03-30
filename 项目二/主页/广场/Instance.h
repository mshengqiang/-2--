//
//  Instance.h
//  UITableView作业01
//
//  Created by Liwy on 16/1/7.
//  Copyright © 2016年 Liwy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instance : NSObject
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *diary;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *could;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *picN;
@property (nonatomic,strong)NSString *zans;
@property (nonatomic,strong)NSString *zanOr;
@property (nonatomic,strong)NSString *idid;
@property (nonatomic,assign)int * titleNum;
@property int flagadd;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableArray *> * dataSource;
@property (nonatomic,strong) NSMutableArray <NSString *> * array;

+ (instancetype)shareInstance;


@end
