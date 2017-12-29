//
//  UIButton+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UIButton+Theme.h"
#import "ThemeProperties.h"
#import "NSObject+Theme.h"
#import "METhemeManager.h"
#import <objc/runtime.h>
@interface UIButton ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end
@implementation UIButton (Theme)

- (void)me_setImage:(_Nullable MEImagePicker)picker forState:(UIControlState)state {
    NSString *key = NSStringFromSelector(@selector(setImage:forState:));
    id dictionary = [self.pickers valueForKey:key];
    if (!dictionary || ![dictionary isKindOfClass:[NSMutableDictionary class]]) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:[picker copy] forKey:[NSString stringWithFormat:@"%@", @(state)]];
    if (!picker) {
        [self setImage:nil forState:state];
        [self.pickers removeObjectForKey:key];
    } else {
        [self setImage:picker() forState:state];
        [self.pickers setValue:dictionary forKey:key];
    }
}
- (void)me_setBackgroundImage:(_Nullable MEImagePicker)picker forState:(UIControlState)state{
    [self setBackgroundImage:picker() forState:state];
    NSString *key = NSStringFromSelector(@selector(setBackgroundImage:forState:));
    id dictionary = [self.pickers valueForKey:key];
    if (!dictionary || ![dictionary isKindOfClass:[NSMutableDictionary class]]) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:[picker copy] forKey:[NSString stringWithFormat:@"%@", @(state)]];
    [self.pickers setValue:dictionary forKey:key];
}
- (void)me_setTitleColor:(_Nullable MEColorPicker)picker forState:(UIControlState)state{
    [self setTitleColor:picker() forState:state];
    NSString *key = NSStringFromSelector(@selector(setTitleColor:forState:));
    id dictionary = [self.pickers valueForKey:key];
    if (!dictionary || ![dictionary isKindOfClass:[NSMutableDictionary class]]) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:[picker copy] forKey:[NSString stringWithFormat:@"%@", @(state)]];
    [self.pickers setValue:dictionary forKey:key];
}

- (void)changeTheme{
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, MEPicker> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, MEPicker  _Nonnull picker, BOOL * _Nonnull stop) {
                UIControlState state = [key integerValue];
                [UIView animateWithDuration:METhemeAnimationDuration
                                 animations:^{
                                     if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleColor:forState:))]) {
                                         UIColor *resultColor = picker();
                                         [self setTitleColor:resultColor forState:state];
                                     } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundImage:forState:))]) {
                                         UIImage *resultImage = ((MEImagePicker)picker)();
                                         [self setBackgroundImage:resultImage forState:state];
                                     } else if ([selector isEqualToString:NSStringFromSelector(@selector(setImage:forState:))]) {
                                         UIImage *resultImage = ((MEImagePicker)picker)();
                                         [self setImage:resultImage forState:state];
                                     }
                                 }];
            }];
        } else {
            SEL sel = NSSelectorFromString(selector);
            id result = ((MEPicker)obj)();
            [UIView animateWithDuration:METhemeAnimationDuration
                             animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                 [self performSelector:sel withObject:result];
#pragma clang diagnostic pop
                             }];
            
        }
    }];
}

- (void)me_setConfigModeSureButton {
    self.me_configKey = ThemeMode_Button_Sure;
    
    
    UIImageResizingMode resizingMode = UIImageResizingModeStretch;
    
    MEImagePicker imagePickerNormal = [UIImage me_imageNamed:@"button_sure_normal" resizableImageWithCapInsets:ThemeMode_Button_Sure_CapInsets resizingMode:resizingMode];
    [self me_setBackgroundImage:imagePickerNormal forState:UIControlStateNormal];
    
    MEImagePicker imagePickerHighlighted = [UIImage me_imageNamed:@"button_sure_highlight" resizableImageWithCapInsets:ThemeMode_Button_Sure_CapInsets resizingMode:resizingMode];
    [self me_setBackgroundImage:imagePickerHighlighted forState:UIControlStateHighlighted];
    
    UIImage *imagePickerDisabled = [[UIImage imageNamed:@"button_sure_disabled"] resizableImageWithCapInsets:ThemeMode_Button_Sure_CapInsets resizingMode:resizingMode];
    [self setBackgroundImage:imagePickerDisabled forState:UIControlStateDisabled];
}


- (NSString *)me_configKey {
    return objc_getAssociatedObject(self, @selector(me_configKey));
}

-(void)setMe_configKey:(NSString *)me_configKey {
    objc_setAssociatedObject(self, @selector(me_configKey), me_configKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self me_setButtonConfigWithMode:me_configKey];
    
}
- (void)me_setButtonConfigWithMode:( NSString * _Nullable )mode {
    if ([mode isEqualToString:ThemeMode_Button_NavBarRight]) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    [self me_ButtonTitleColorForMode:mode withState:UIControlStateNormal];
    [self me_ButtonTitleColorForMode:mode withState:UIControlStateHighlighted];
    [self me_ButtonTitleColorForMode:mode withState:UIControlStateDisabled];
    [self me_ButtonTitleColorForMode:mode withState:UIControlStateSelected];
}

#pragma mark - GET Color
- (MEColorPicker)getButtonTitleColorForMode:(NSString *)mode withState:(UIControlState)state{
    return ^() {
        NSString *colorHexStr = [METhemeManager sharedThemeManager].currentThemeConfig[@"Button"][mode][@"titleColor"][[self buttonControlStateToStr:state]];
        UIColor  *color = [UIColor me_colorWithHexString:colorHexStr];
        if (color == nil) {
            color = [self titleColorForState:state];
        }
        return color;
    };
}
- (void)me_ButtonTitleColorForMode:(NSString *)mode withState:(UIControlState)state{
    MEColorPicker colorPicker = [self getButtonTitleColorForMode:mode withState:state];
    [self me_setTitleColor:colorPicker forState:state];
}
- (NSString *)buttonControlStateToStr:(UIControlState)state{
    NSString *str = @"UIControlStateNormal";
    switch (state) {
        case UIControlStateHighlighted:
            str = @"UIControlStateHighlight";
            break;
        case UIControlStateDisabled:
            str = @"UIControlStateDisabled";
            break;
        case UIControlStateSelected:
            str = @"UIControlStateSelected";
            break;
        default:
            break;
    }
    return str;
}
@end
