//
//  UILabel+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UILabel+Theme.h"
#import "NSObject+Theme.h"
#import <objc/runtime.h>

@implementation UILabel (Theme)
-(MEColorPicker)me_textColor{
    return objc_getAssociatedObject(self, @selector(me_textColor));
}
-(void)setMe_textColor:(MEColorPicker)me_textColor{
    //注册新属性的set方法
    objc_setAssociatedObject(self, @selector(me_textColor), me_textColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //调用原始的方法
    self.textColor = me_textColor();
    //保存主题填充的操作，将(MEColorPicker)me_textColor参数和"setTextColor:"方法绑定保存
    [self.pickers setValue:[me_textColor copy] forKey:@"setTextColor:"];
}

@end
