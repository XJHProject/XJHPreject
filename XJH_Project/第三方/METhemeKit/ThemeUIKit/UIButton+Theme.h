//
//  UIButton+Theme.h
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Theme.h"
#import "UIImage+Theme.h"
@interface UIButton (Theme)

- (void)me_setImage:(_Nullable MEImagePicker)picker forState:(UIControlState)state;
- (void)me_setBackgroundImage:(_Nullable MEImagePicker)picker forState:(UIControlState)state;
- (void)me_setTitleColor:(_Nullable MEColorPicker)picker forState:(UIControlState)state;

@property (nonatomic, strong,nullable) NSString * me_configKey;

// 确定按钮要用这个方法
- (void)me_setConfigModeSureButton;
@end
