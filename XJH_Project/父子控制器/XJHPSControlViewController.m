//
//  XJHPSControlViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 17/4/12.
//  Copyright © 2017年 熊进辉. All rights reserved.
//

#import "XJHPSControlViewController.h"
#import "XJHTabBarController.h"
#import "UIView+Extension.h"

static CGFloat const labelW = 100;
#define  ScreenW  [UIScreen mainScreen].bounds.size.width

@interface XJHPSControlViewController ()
@property(nonatomic,strong)UIScrollView *titleScrollview;
@property(nonatomic,strong)UIView       *contentView;
@property(nonatomic,strong)UILabel      *selLabel;

@end

@implementation XJHPSControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"网易新闻";
    //添加子控制器
    [self addSelfChirdViewController];
    //设置标题
    [self setUpTitleScrollView];
    //
    [self setUpcontentView];
    //设置标题label
    [self setUpTitleLabel];
}
-(void)setUpTitleScrollView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    scrollView.backgroundColor=[UIColor blueColor];
    self.titleScrollview=scrollView;
    [self.view addSubview: scrollView];
    NSUInteger count=self.childViewControllers.count;
    scrollView.contentSize=CGSizeMake(count*labelW, 0);
    scrollView.showsHorizontalScrollIndicator=NO;
}
-(void)setUpcontentView{
    UIView *content=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollview.frame), self.view.width, self.view.height-44)];
    self.contentView=content;
    content.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:content];
     }
-(void)setUpTitleLabel{
    NSUInteger count=self.childViewControllers.count;
    for (int i=0; i<count; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(labelW*i,0, labelW, 44)];
        UIViewController *vc=self.childViewControllers[i];
        label.text=vc.title;
        label.userInteractionEnabled=YES;
        label.highlightedTextColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
        label.tag=i;
        [self.titleScrollview addSubview:label];
    }
}
-(void)addSelfChirdViewController{
    NSArray *arr=@[@"TopViewController",@"HotViewController",@"VideoViewController",@"SocietyViewController",@"ReaderViewController",@"ScienceViewController"];
    NSArray *titleArr=@[@"头条",@"热点",@"视频",@"社会",@"阅读",@"科技"];
    for (int i=0;i<arr.count ; i++) {
        UIViewController *vc = [[NSClassFromString(arr[i]) alloc]init];
        vc.title=titleArr[i];
        [self addChildViewController:vc];
    }
    
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"%s",__func__);
    //标题变色
    UILabel *selLabel=(UILabel *)tap.view;
    [self selectLabel:selLabel];
    //
   
}
-(void)selectLabel:(UILabel *)label{
    self.selLabel.highlighted=NO;
    label.highlighted=YES;
    self.selLabel=label;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.hidesBottomBarWhenPushed=YES;
    [[XJHTabBarController shareSingeleton] hide];
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
