//
//  CYBaseViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/11/23.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "CYBaseViewController.h"
#import "XJHNavigationController.h"

@interface CYBaseViewController ()

@end

@implementation CYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeNavBarBackgroundWithType{
    /**
     *  手势返回的时候滑动一半不返回，这里做导航条的背景颜色更改，主要针对导航条背景颜色不一致的页面
     */
    if (self.navigationController.viewControllers.lastObject == self) {
        if ([self.navigationController isKindOfClass:[XJHNavigationController class]]) {
            XJHNavigationController *baseNav = (XJHNavigationController *)self.navigationController;
            [baseNav changeNavBarType:NavBarLevel1];
        }
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
