//
//  XJHTools.h
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJHTools : NSObject
+(XJHTools *)shareTools;
@property(nonatomic,assign)NSInteger skipPage;//用于跳转到其他界面

@end
