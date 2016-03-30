//
//  Instance.m
//  UITableView作业01
//
//  Created by Liwy on 16/1/7.
//  Copyright © 2016年 Liwy. All rights reserved.
//

#import "Instance.h"



@implementation Instance

static Instance * instance = nil;
+ (instancetype)shareInstance
{
    if (!instance) {
        instance = [[Instance alloc] init];
        instance.dataSource = [[NSMutableDictionary alloc] init];
        instance.array = [[NSMutableArray alloc]init];
    }
    return instance;
}


@end




