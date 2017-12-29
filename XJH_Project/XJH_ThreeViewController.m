//
//  XJH_ThreeViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJH_ThreeViewController.h"
#import "UIView+Extension.h"
#import <BlocksKit+UIKit.h>
#import "XJHTabBarController.h"
#import "METhemeKit.h"

@interface XJH_ThreeViewController ()

@end

@implementation XJH_ThreeViewController
+(XJH_ThreeViewController *)shareVC{
    static XJH_ThreeViewController *threeVC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        threeVC=[[self alloc]init];
    });
    return threeVC;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[XJHTabBarController shareSingeleton] show];
    [self setHidesBottomBarWhenPushed:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"three";
    self.view.me_backgroundColor=[UIColor me_colorPickerForMode:ViewBackgoundColor];
    //
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"父子控制器" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];
    //
    UIButton *btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.width=100;
    btn.height=30;
    btn.x=self.view.width/2-btn.width/2;
    btn.y=self.view.height/2-btn.height/2;
    [btn setTitle:@"ToFour" forState:(UIControlStateNormal)];
    btn.me_configKey=ButtonTypeColor;
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn bk_addEventHandler:^(id sender) {
        [[XJHTabBarController shareSingeleton] skipToOtherViewControllerWithTag:3];
        NSString *path=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        path=[path stringByAppendingPathComponent:@"boy.png"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"boy" ofType:@"png"];
            NSData *imageData=[NSData dataWithContentsOfFile:imagePath];
            [imageData writeToFile:path atomically:YES];
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn];
}
-(void)leftAction{
    UIViewController *vc=[[NSClassFromString(@"XJHPSControlViewController") alloc]init] ;
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
