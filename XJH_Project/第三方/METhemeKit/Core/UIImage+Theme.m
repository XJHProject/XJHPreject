//
//  UIImage+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UIImage+Theme.h"
#import "METhemeManager.h"
@implementation UIImage (Theme)
+(MEImagePicker)me_imageNamed:(NSString *)name {
    return ^() {
        //获得主题前缀
        NSString *pre = [METhemeManager getImageNamePrefix];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",pre,name]];
        if (image) {
            return image;
        }else {
            //如果根据前缀没有读取到图片，则读取原始图片
            return [UIImage imageNamed:name];
        }
    };
}
+(MEImagePicker)me_imageNamed:(NSString *)name
  resizableImageWithCapInsets:(UIEdgeInsets)capInsets{
    return ^() {
        NSString *pre = [METhemeManager getImageNamePrefix];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",pre,name]];
        
        if (image) {
            UIImage *resiableImage = [image resizableImageWithCapInsets:capInsets];
            return resiableImage;
        }else {
            UIImage *defaultImage = [UIImage imageNamed:name];
            UIImage *resiableImage = [defaultImage resizableImageWithCapInsets:capInsets];
            return resiableImage;
        }
    };
}

+(MEImagePicker)me_imageNamed:(NSString *)name
  resizableImageWithCapInsets:(UIEdgeInsets)capInsets
                 resizingMode:(UIImageResizingMode)resizingMode {
    return ^() {
        NSString *pre = [METhemeManager getImageNamePrefix];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",pre,name]];
        
        if (image) {
            UIImage *resiableImage = [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
            return resiableImage;
        }else {
            UIImage *defaultImage = [UIImage imageNamed:name];
            UIImage *resiableImage = [defaultImage resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
            return resiableImage;
        }
    };
}

+ (UIImage *)me_createImageFromColor:(MEColorPicker)colorPicker {
    UIColor *color = colorPicker();
    if (!color) {
        return nil;
    }
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
