//
//  XJH_FiveViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJH_FiveViewController.h"
#import "UIView+Extension.h"
#import <BlocksKit+UIKit.h>
#import "XJHTabBarController.h"
#import "METhemeKit.h"
#import "ZCodeViewController.h"

@interface XJH_FiveViewController ()

@end

@implementation XJH_FiveViewController
+(XJH_FiveViewController *)shareVC{
    static XJH_FiveViewController *fiveVC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fiveVC=[[self alloc]init];
    });
    return fiveVC;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[XJHTabBarController shareSingeleton] show];
    [self setHidesBottomBarWhenPushed:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"five";
    self.view.me_backgroundColor=[UIColor me_colorPickerForMode:ViewBackgoundColor];
    UIButton *btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.width=100;
    btn.height=30;
    btn.x=self.view.width/2-btn.width/2;
    btn.y=self.view.height/2-btn.height/2;
    [btn setTitle:@"ToOne" forState:(UIControlStateNormal)];
    btn.me_configKey=ButtonTypeColor;
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn bk_addEventHandler:^(id sender) {
        [[XJHTabBarController shareSingeleton] skipToOtherViewControllerWithTag:0];
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn];
    //
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"二维码" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];
    
}
-(void)leftAction{
    ZCodeViewController * vc=[[ZCodeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
