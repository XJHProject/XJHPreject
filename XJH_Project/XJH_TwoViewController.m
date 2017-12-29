//
//  XJH_TwoViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJH_TwoViewController.h"
#import "UIView+Extension.h"
#import <BlocksKit+UIKit.h>
#import "XJHTabBarController.h"
#import "METhemeKit.h"

@interface XJH_TwoViewController ()

@end

@implementation XJH_TwoViewController
+(XJH_TwoViewController *)shareVC{
    static XJH_TwoViewController *twoVC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        twoVC=[[self alloc]init];
    });
    return twoVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"two";
    self.view.me_backgroundColor=[UIColor me_colorPickerForMode:ViewBackgoundColor];
    //
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"写文件" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"读文件" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction)];

    //
    UIButton *btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.width=100;
    btn.height=30;
    btn.x=self.view.width/2-btn.width/2;
    btn.y=self.view.height/2-btn.height/2;
    [btn setTitle:@"ToThree" forState:(UIControlStateNormal)];
    btn.me_configKey=ButtonTypeColor;
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn bk_addEventHandler:^(id sender) {
        [[XJHTabBarController shareSingeleton] skipToOtherViewControllerWithTag:2];
       
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[XJHTabBarController shareSingeleton] show];
    [self setHidesBottomBarWhenPushed:YES];
}
-(void)leftAction{
    NSInteger num=arc4random()%3;
    NSLog(@"%ld",num);
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
     if (num==0) {
        NSLog(@"将字符串写入文本文件");
        path=[NSString stringWithFormat:@"%@/string.txt",path];
        NSString *string=@"Hello,world";
        NSError *error;
        [string writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:&error];
     }else if (num==1){
         NSLog(@"将Array写入plist文件");
         path=[NSString stringWithFormat:@"%@/array.plist",path];
         NSArray *array=@[@"张工人",@"黄五金",@"刘四宝"];
         [array writeToFile:path atomically:NO];
     }else{
         NSLog(@"将Dic写入plist文件");
         path=[NSString stringWithFormat:@"%@/dictionary.plist",path
               ];
         NSDictionary *dic=@{@"one":@(1),@"two":@(2),@"three":@(3)};
         [dic writeToFile:path atomically:NO];
         
     }
    NSLog(@"%@",path);
}
-(void)rightAction{
    NSInteger num=arc4random()%3;
     NSLog(@"%ld",num);
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    if (num==0) {
        path=[NSString stringWithFormat:@"%@/string.txt",path];
        NSString *string=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"string:%@",string);
    }else if(num==1){
        path=[NSString stringWithFormat:@"%@/array.plist",path];
        NSArray *arr=[NSArray arrayWithContentsOfFile:path];
        NSLog(@"array:%@",arr);
    }else{
        path=[NSString stringWithFormat:@"%@/dictionary.plist",path];
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
        NSLog(@"dictionary:%@",dic);
    }
    NSLog(@"%@",path);
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
