//
//  SetViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/11/24.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "SetViewController.h"
#import "METhemeKit.h"
#import "XJHTabBarController.h"
#import "UIView+Extension.h"
#import "METhemeKit.h"


@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.view.me_backgroundColor=[UIColor me_colorPickerForMode:ViewBackgoundColor];
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(100, 100, 100, 30);
    label.text=@"熊进辉";
    label.me_textColor=[UIColor me_colorPickerForMode:CharacterColor];
    [self.view addSubview:label];
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 40, 90, 30);
//    [button me_setTitleColor:[UIColor me_colorPickerForMode:ViewBackgoundColor] forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor colorWithRed:0.5397 green:0.9142 blue:0.5158 alpha:1.0]];
    [button me_setImage:[UIImage me_imageNamed:@"ico_news_mnjy"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(changeTheme) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"切换主题" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    //
    UIImageView *imageV=[[UIImageView alloc]init];
    imageV.x=20;
    imageV.y=130;
    imageV.size=CGSizeMake(self.view.width-40, 200);
    imageV.me_image=[UIImage me_imageNamed:@"boy"];
    imageV.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageV];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHidesBottomBarWhenPushed:YES];
    [[XJHTabBarController shareSingeleton] hide];
}
- (void)changeTheme{
    ThemeType type = [METhemeManager sharedThemeManager].themeType;
    if (type == ThemeDefault) {
        [METhemeManager sharedThemeManager].themeType = ThemeYear;
    } else {
        [METhemeManager sharedThemeManager].themeType = ThemeDefault;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
