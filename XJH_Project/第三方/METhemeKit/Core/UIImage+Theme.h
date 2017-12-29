//
//  UIImage+Theme.h
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Theme.h"
typedef UIImage *(^MEImagePicker)(void);
typedef NSString *(^MEImageNamePicker)(void);
typedef NSArray *(^MEArrayPicker)(void);

@interface UIImage (Theme)
+ (MEImagePicker)me_imageNamed:(NSString *)name;


+ (MEImagePicker)me_imageNamed:(NSString *)name
  resizableImageWithCapInsets:(UIEdgeInsets)capInsets;

+ (MEImagePicker)me_imageNamed:(NSString *)name
  resizableImageWithCapInsets:(UIEdgeInsets)capInsets
                 resizingMode:(UIImageResizingMode)resizingMode;

+ (UIImage *)me_createImageFromColor:(MEColorPicker)colorPicker;
@end
