//
//  XJHNavigationController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJHNavigationController.h"
#import "XJH_OneViewController.h"

@interface XJHNavigationController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)id popDelegate;
@end

@implementation XJHNavigationController
+(void)initialize{
    if (self==[XJHNavigationController class]) {
        UINavigationBar *bar=[UINavigationBar appearance];
        [bar setBarStyle:(UIBarStyleBlack)];//修改状态栏颜色
        [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];//修改导航栏文字颜色大小
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate=self.interactivePopGestureRecognizer.delegate;
    self.delegate=self;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        UIButton *backBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn setImage:[UIImage imageNamed:@"ico_turnleft"] forState:(UIControlStateNormal)];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        CGRect frame=backBtn.frame;
        frame.size.width=40;
        frame.size.height=40;
        backBtn.frame=frame;
        [backBtn addTarget:self action:@selector(popToPre) forControlEvents:(UIControlEventTouchUpInside)];
        UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem=leftBarButton;
        
    }
    [super pushViewController:viewController animated:animated];
}
-(void)popToPre{
    [self popViewControllerAnimated:YES];
}
-(void)changeNavBarType:(NavBarType)navBarType{
    [self.navigationBar me_setBackgroundImageForBarMetrics:UIBarMetricsDefault WithType:navBarType];
    if (navBarType == NavBarLevel1) {
        self.navigationBar.shadowImage = [UIImage imageNamed:@"navigationBarShadowImage"];
    } else {
        self.navigationBar.shadowImage = [UIImage new];
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //    NSLog(@" willShowViewController %@ ; viewControlers %@",viewController,navigationController.viewControllers);
    
//    if ([viewController isKindOfClass:[XJH_OneViewController class]]) {
        [self changeNavBarType:NavBarDefault];  // 修改导航栏 背景颜色
        
//    } else {
//        [self changeNavBarType:NavBarLevel1]; // 修改导航栏 背景颜色
//    }
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
