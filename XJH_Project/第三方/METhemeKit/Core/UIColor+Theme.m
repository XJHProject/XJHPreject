//
//  UIColor+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UIColor+Theme.h"
#import "METhemeManager.h"
#import "NSObject+Theme.h"
@implementation UIColor (Theme)
+ (UIColor *)me_colorWithHexString:(NSString *) hexString
{
    if (!hexString) {
        return nil;
    }
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 0:
            return nil;
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            alpha = 0, red = 0, blue = 0, green = 0;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
+ (CGFloat) colorComponentFrom: (NSString *) string start:(NSUInteger) start length:(NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}




#pragma mark - binding property
#pragma mark - binding
+ (NSString *)getColorForMode:(NSString *)mode {
    //这里通过管理类拿到当前主题的配置文件(是一个字典)，然后根据key值来获取对应的颜色
    NSString *colorStr = [METhemeManager sharedThemeManager].currentThemeConfig[@"Color"][mode];
    return colorStr;
}
+ (MEColorPicker)me_colorPickerForMode:(NSString *)mode {
    return ^() {
        NSString *colorHexStr = [self getColorForMode:mode];
        return [self me_colorWithHexString:colorHexStr];
    };
}



#pragma mark - CGColor
+ (MECGColorPicker)me_cgcolorPickerWithMode:(NSString *)mode {
    return ^() {
        NSString *colorHexStr = [self getColorForMode:mode];
        UIColor *color = [self me_colorWithHexString:colorHexStr];
        return [color CGColor];
    };
}


@end
