//
//  UIView+Theme.m
//  neighborhood
//
//  Created by ss on 16/1/18.
//  Copyright © 2016年 iYaYa. All rights reserved.
//

#import "UIView+Theme.h"
#import "NSObject+Theme.h"
#import <objc/runtime.h>
@implementation UIView (Theme)
- (MEColorPicker)me_backgroundColor{
    return objc_getAssociatedObject(self, @selector(me_backgroundColor));
}
- (void)setMe_backgroundColor:(MEColorPicker)me_backgroundColor{
    objc_setAssociatedObject(self, @selector(me_backgroundColor), me_backgroundColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.backgroundColor = me_backgroundColor();
    [self.pickers setValue:[me_backgroundColor copy] forKey:@"setBackgroundColor:"];
}
@end
