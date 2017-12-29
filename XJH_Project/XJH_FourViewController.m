//
//  XJH_FourViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJH_FourViewController.h"
#import "UIView+Extension.h"
#import <BlocksKit+UIKit.h>
#import "XJHTabBarController.h"
#import "SetViewController.h"
#import "METhemeKit.h"
#import "VideoListViewController.h"

@interface XJH_FourViewController ()

@end

@implementation XJH_FourViewController
+(XJH_FourViewController*)shareVC{
    static XJH_FourViewController *fourVC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fourVC=[[self alloc]init];
    });
    return fourVC;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[XJHTabBarController shareSingeleton] show];
    [self setHidesBottomBarWhenPushed:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"four";
    self.view.me_backgroundColor=[UIColor me_colorPickerForMode:ViewBackgoundColor];
    UIButton *btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.width=100;
    btn.height=30;
    btn.x=self.view.width/2-btn.width/2;
    btn.y=self.view.height/2-btn.height/2;
    [btn setTitle:@"ToFive" forState:(UIControlStateNormal)];
    btn.me_configKey=ButtonTypeColor;
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn bk_addEventHandler:^(id sender) {
        [[XJHTabBarController shareSingeleton] skipToOtherViewControllerWithTag:4];
    } forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem=left;
    [self.view addSubview:btn];
    //直播
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"直播" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=right;
    
}
-(void)leftAction{
 
    SetViewController *setVC=[SetViewController new];
    [self.navigationController pushViewController:setVC animated:YES];
}
-(void)rightAction{
//    VideoListViewController *video=[[VideoListViewController alloc]init];
//    [self.navigationController pushViewController:video animated:YES];
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
