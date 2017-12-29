//
//  XJHTools.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJHTools.h"

@implementation XJHTools
+(XJHTools *)shareTools{
    static XJHTools *tools=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools=[[self alloc]init];
    });
    return tools;
}
@end
