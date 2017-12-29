//
//  UIImageView+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UIImageView+Theme.h"
#import "NSObject+Theme.h"
#import <objc/runtime.h>

@implementation UIImageView (Theme)
- (instancetype)me_initWithImage:(MEImagePicker)imagePicker{
    if ([self initWithImage:imagePicker()]) {
        [self.pickers setObject:[imagePicker copy] forKey:@"setImage:"];
        return self;
    }
    return nil;
}
-(MEImagePicker)me_image{
    return objc_getAssociatedObject(self, @selector(me_image));
}

-(void)setMe_image:(MEImagePicker)me_image{
    objc_setAssociatedObject(self, @selector(me_image), me_image, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = me_image();
    [self.pickers setObject:[me_image copy] forKey:@"setImage:"];
}

@end




