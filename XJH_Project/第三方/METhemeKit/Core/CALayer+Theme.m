//
//  CALayer+Theme.m
//  neighborhood
//
//  Created by 杨世昌 on 16/1/18.
//  Copyright © 2016年 iYaYa. All rights reserved.
//

#import "CALayer+Theme.h"
#import "NSObject+Theme.h"
#import <objc/runtime.h>
@implementation CALayer (Theme)

-(MECGColorPicker)me_borderColor{
    return objc_getAssociatedObject(self, @selector(me_borderColor));
}
-(void)setMe_borderColor:(MECGColorPicker)me_borderColor {
    objc_setAssociatedObject(self, @selector(me_borderColor), me_borderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.borderColor = me_borderColor();
    
    [self.pickers setValue:[me_borderColor copy] forKey:@"setBorderColor:"];
}

- (MECGColorPicker)me_backgroundColor{
    return objc_getAssociatedObject(self, @selector(me_backgroundColor));
}
- (void)setMe_backgroundColor:(MECGColorPicker)me_backgroundColor{
    objc_setAssociatedObject(self, @selector(me_backgroundColor), me_backgroundColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.backgroundColor = me_backgroundColor();
    [self.pickers setValue:[me_backgroundColor copy] forKey:@"setBackgroundColor:"];
}
@end
