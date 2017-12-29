//
//  METhemeManager.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "METhemeManager.h"
#import <UIKit/UIKit.h>
#import "ThemeProperties.h"
#define BlackColorHex @"000000"

static METhemeManager *instance = nil;

@interface METhemeManager ()

@end

@implementation METhemeManager
+ (void)load{
    [super load];
    [METhemeManager sharedThemeManager];
}
+ (METhemeManager *)sharedThemeManager {
    @synchronized(self){//为了确保多线程情况下，仍然确保实体的唯一性
        if (!instance) {
            instance = [[self alloc] init]; //确保使用同一块内存地址
        }
    }
    return instance;
}
+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){// //为了确保多线程情况下，仍然确保实体的唯一性
        if (!instance) {
            instance = [super allocWithZone:zone]; //确保使用同一块内存地址
            return instance;
        }
    }
    return nil;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.themeType = [self getTypeFromLocal];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone;{
    return self; //确保copy对象也是唯一
}

- (void)setThemeType:(ThemeType)themeType {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _themeType = themeType;
        NSString *path;
        switch (themeType) {
            case ThemeDefault:{
                _imageNamePrefix = @"";
                path = [[NSBundle mainBundle]pathForResource:@"ThemeDefault" ofType:@"json"];
            }
                break;
            case ThemeYear:{
                _imageNamePrefix = @"year_";
                path = [[NSBundle mainBundle]pathForResource:@"ThemeOrange" ofType:@"json"];
            }
                break;
            default:
                break;
        }
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        _currentThemeConfig = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        if (_currentThemeConfig == nil) {
            NSAssert(false, @"ThemeConfig配置有误", self);
            abort();
        }
        //保存当前配置到本地
        [self saveTypeLocal:themeType];
        
        /**
         *  发送通知
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kMEThemeChangeNotification object:nil];
        });
    });
}
#pragma mark - 获取配置
#pragma mark - 获取图片名字前缀
+ (NSString *)getImageNamePrefix{
    return [METhemeManager sharedThemeManager].imageNamePrefix;
}

- (void)saveTypeLocal:(ThemeType)themeType{
    [[NSUserDefaults standardUserDefaults]setInteger:themeType forKey:ThemeTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (ThemeType)getTypeFromLocal{
    ThemeType type = [[NSUserDefaults standardUserDefaults]integerForKey:ThemeTypeKey];
    return type;
}







@end
