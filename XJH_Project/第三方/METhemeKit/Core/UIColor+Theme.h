//
//  UIColor+Theme.h
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef UIColor *(^MEColorPicker)(void);
typedef CGColorRef (^MECGColorPicker)(void);

@interface UIColor (Theme)
+ (UIColor *)me_colorWithHexString:(NSString *) hexString;
#pragma mark - binding property
+ (MEColorPicker)me_colorPickerForMode:(NSString *)mode;

#pragma mark - CGColor
+ (MECGColorPicker)me_cgcolorPickerWithMode:(NSString *)mode;

@end
