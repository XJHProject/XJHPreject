//
//  UIImageView+Theme.h
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Theme.h"
@interface UIImageView (Theme)
@property (nonatomic,copy)MEImagePicker me_image;
- (instancetype)me_initWithImage:(MEImagePicker)imagePicker;
@end
