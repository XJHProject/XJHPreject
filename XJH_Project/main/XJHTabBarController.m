//
//  XJHTabBarController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJHTabBarController.h"
#import "XJHNavigationController.h"
#import "XJH_OneViewController.h"
#import "XJH_FiveViewController.h"
#import "XJHTools.h"
#import "METhemeKit.h"


#define btnTag 888

#define color [UIColor colorWithRed:0/255.0 green:156/255.0 blue:237/255.0 alpha:1]
#define ScreenHEIGH [UIScreen mainScreen].bounds.size.height
#define ScreenWIDTH [UIScreen mainScreen].bounds.size.width
@interface XJHTabBarController ()
@property(nonatomic,strong)UIView *tabBarView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger timerValue;
@end

@implementation XJHTabBarController
+(XJHTabBarController *)shareSingeleton{
    static XJHTabBarController *tabBar=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBar=[[self alloc]init];
    });
    return tabBar;
}
-(void)hide{
    CGRect rect=_tabBarView.frame;
    rect.origin.y=ScreenHEIGH;
    _tabBarView.frame=rect;
    
}
-(void)show{
    self.tabBar.hidden=YES;
    CGRect rect=_tabBarView.frame;
    rect.origin.y=ScreenHEIGH-50;
    _tabBarView.frame=rect;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.timerValue=0;
    self.tabBar.hidden=YES;//隐藏自带的tabBar
    //设置self.title的格式
    UIBarButtonItem *barItem=[UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} forState:(UIControlStateNormal)];
    [self instanceViewControllers];
    [self instanceBar];
//    [self timer];
}
-(void)instanceViewControllers{
    NSArray *VCs=@[@"XJH_OneViewController",
                   @"XJH_TwoViewController",
                   @"XJH_ThreeViewController",
                   @"XJH_FourViewController",
                   @"XJH_FiveViewController"];
    NSMutableArray *navs=[[NSMutableArray alloc]init];
    for (NSString *vcStr in VCs) {
        UIViewController *vc=[NSClassFromString(vcStr) shareVC];
        XJHNavigationController *nav=[[XJHNavigationController alloc]initWithRootViewController:vc];
        //设置导航栏颜色
        [nav.navigationBar setBarTintColor:color];
        [navs addObject:nav];
        
    }
    self.viewControllers=navs;
    
}
-(void)instanceBar{
    self.tabBarView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHEIGH-50, ScreenWIDTH, 50)];
    self.tabBarView.layer.borderWidth=0.5;
    self.tabBarView.layer.borderColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.tabBarView.me_backgroundColor=[UIColor me_colorPickerForMode:TabBarBackgroundColor];
    [self.view addSubview:self.tabBarView];
    CGFloat width=self.view.bounds.size.width/self.viewControllers.count;
    NSArray *nameArr=@[@"one",@"two",@"three",@"four",@"five"];
    for (int i=0; i<self.viewControllers.count; i++) {
        UIButton *btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame=CGRectMake(width*i, 0, width, 50);
        [btn setTitle:nameArr[i] forState:(UIControlStateNormal)];
        btn.me_configKey=ButtonTypeColor;
        btn.me_backgroundColor=[UIColor me_colorPickerForMode:TabBarBackgroundColor];
//        btn.backgroundColor=color;
        btn.tag=btnTag+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.tabBarView addSubview:btn];
        if (i==0) {
            btn.enabled=NO;
        }
    }
}
-(void)btnAction:(UIButton *)sender{
    for (int i=0; i<self.viewControllers.count; i++) {
        UIButton *btn=(UIButton *)[self.tabBarView viewWithTag:btnTag+i];
        btn.enabled=YES;
//        btn.backgroundColor=color;
    }
    sender.enabled=NO;
//    sender.backgroundColor=[UIColor whiteColor];
    self.selectedIndex=sender.tag-btnTag;
    
}
-(void)skipToOtherViewControllerWithTag:(NSInteger)tag{
    for (int i=0; i<self.viewControllers.count; i++) {
        UIButton *btn=(UIButton *)[self.tabBarView viewWithTag:btnTag+i];
        btn.enabled=YES;
//        btn.backgroundColor=color;
    }
    UIButton *sender=(UIButton *)[self.tabBarView viewWithTag:btnTag+tag];
    sender.tag=btnTag+tag;
    sender.enabled=NO;
//    sender.backgroundColor=[UIColor whiteColor];
    self.selectedIndex=sender.tag-btnTag;
    [XJHTools shareTools].skipPage=tag;
    [self show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSTimer *)timer {
    if(_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return _timer;
}
-(void)timerAction{
    if ([self.timer isValid]) {
        self.timerValue++;
        [self skipToOtherViewControllerWithTag:self.timerValue%5];
    }else{
        [self.timer invalidate];
        self.timer=nil;
    }
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
