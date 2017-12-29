//
//  XJHTabBarController.h
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJHTabBarController : UITabBarController
+(XJHTabBarController *)shareSingeleton;//单例
-(void)hide;//隐藏
-(void)show;//显示
-(void)skipToOtherViewControllerWithTag:(NSInteger)tag;//跳转
@end
