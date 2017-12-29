//
//  UINavigationBar+Theme.h
//  ThemeDemo
//
//  Created by ss on 16/1/13.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Theme.h"
typedef NS_ENUM(NSUInteger,NavBarType) {
    NavBarDefault = 0,
    NavBarLevel1
};
@interface UINavigationBar (Theme)
- (void)me_setBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics WithType:(NavBarType)navType;
- (void)me_setShadowImageForType:(NavBarType)navType;
#pragma mark TitleColor
- (MEColorPicker)me_navBarTitleColorWithType:(NavBarType)navBarType;
@end
