//
//  UINavigationBar+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/13.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UINavigationBar+Theme.h"
#import "ThemeProperties.h"
#import "METhemeManager.h"
#import "NSObject+Theme.h"
#import "UIImage+Theme.h"
#import <objc/runtime.h>
@interface UINavigationBar ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end
@implementation UINavigationBar (Theme)
- (void)me_setShadowImageForType:(NavBarType)navType{
    MEColorPicker picker = [self me_navBarShadowImageColorWithType:navType];
    self.shadowImage = [UIImage me_createImageFromColor:picker];
    [self.pickers setValue:[picker copy] forKey:@"setShadowImage:"];
}
- (void)me_setBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics WithType:(NavBarType)navType{
    NSString *key = [NSString stringWithFormat:@"%@", @(barMetrics)];
    MEColorPicker colorPicker = [self me_NavBarBackgroundColor:navType];
    [self setBackgroundImage:[UIImage me_createImageFromColor:colorPicker] forBarMetrics:barMetrics];
    id dictionary = [self.pickers valueForKey:key];
    if (!dictionary || ![dictionary isKindOfClass:[NSMutableDictionary class]]) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:[colorPicker copy] forKey:NSStringFromSelector(@selector(setBackgroundImage:forBarMetrics:))];
    [self.pickers setValue:dictionary forKey:key];
}
- (void)changeTheme{
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, MEPicker> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, MEPicker  _Nonnull picker, BOOL * _Nonnull stop) {
                UIBarMetrics state = [key integerValue];
                [UIView animateWithDuration:METhemeAnimationDuration
                                 animations:^{
                                     if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundImage:forBarMetrics:))]) {
                                         UIImage *resultImage = ([UIImage me_createImageFromColor:(MEColorPicker)picker]);
                                         [self setBackgroundImage:resultImage forBarMetrics:state];
                                     }
                                 }];
            }];
        } else {
            if ([key isEqualToString:NSStringFromSelector(@selector(setShadowImage:))]) {
                MEColorPicker picker = obj;
                self.shadowImage = [UIImage me_createImageFromColor:picker];
            } else{
                SEL sel = NSSelectorFromString(key);
                MEPicker picker = (MEPicker)obj;
                id result = picker();
                [UIView animateWithDuration:METhemeAnimationDuration
                                 animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                     [self performSelector:sel withObject:result];
#pragma clang diagnostic pop
                                 }];
            }
            
            
        }
    }];
}
#pragma mark - GET Color
#warning 如果NavBarType更新这里也要更改
- (NSString *)navBarTypeToStr:(NavBarType)navBarType{
    NSString *str = @"NavBarDefault";
    switch (navBarType) {
        case NavBarLevel1:
            str = @"NavBarLevel1";
            break;
        default:
            break;
    }
    return str;
}

#pragma mark BackgroundImageColor
- (MEColorPicker)me_NavBarBackgroundColor:(NavBarType)navBarType{
    return ^() {
        NSString *colorHexStr = [METhemeManager sharedThemeManager].currentThemeConfig[@"UINavigationBar"][[self navBarTypeToStr:navBarType]][@"backgroundImageColor"];
        return [UIColor me_colorWithHexString:colorHexStr];
    };
}
#pragma mark BarShadowImageColor
- (MEColorPicker)me_navBarShadowImageColorWithType:(NavBarType)navBarType{
    return ^() {
        NSString *colorHexStr = [METhemeManager sharedThemeManager].currentThemeConfig[@"UINavigationBar"][[self navBarTypeToStr:navBarType]][@"shadowImageColor"];
        return [UIColor me_colorWithHexString:colorHexStr];
    };
}

#pragma mark TitleColor
- (MEColorPicker)me_navBarTitleColorWithType:(NavBarType)navBarType{
    return ^() {
        NSString *colorHexStr = [METhemeManager sharedThemeManager].currentThemeConfig[@"UINavigationBar"][[self navBarTypeToStr:navBarType]][@"titleLabelColor"];
        return [UIColor me_colorWithHexString:colorHexStr];
    };
}

@end
