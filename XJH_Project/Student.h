//
//  Student.h
//  XJH_Project
//
//  Created by 熊进辉 on 16/9/5.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,copy)NSString *number;
//单例
+(Student *)shared;
@end
