//
//  METhemeManager.h
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,ThemeType) {
    ThemeDefault = 0,
    ThemeYear = 1,
};


@interface METhemeManager : NSObject
///当前主题，以及主题的修改，重写了set方法，set方法里面发送通知
@property (nonatomic,assign) ThemeType themeType;
///当前主题的配置参数
@property (nonatomic, strong, readonly) NSDictionary *currentThemeConfig;
///图片名字前缀
@property (nonatomic, strong, readonly) NSString *imageNamePrefix;

///`METhemeManager`应该作为单例出现在工程中
+ (METhemeManager *)sharedThemeManager;

///当前主题图片名字前缀
+ (NSString *)getImageNamePrefix;




@end
