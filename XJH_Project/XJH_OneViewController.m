//
//  XJH_OneViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/8/22.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "XJH_OneViewController.h"
#import "UIView+Extension.h"
#import <BlocksKit+UIKit.h>
#import "XJHTabBarController.h"
#import "Student.h"
#import "METhemeKit.h"
#import "XJH_ImgaeViewController.h"
#import "MXPhotoPickerController.h"
#import "UIViewController+MXPhotoPicker.h"

@interface XJH_OneViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation XJH_OneViewController
+(XJH_OneViewController *)shareVC{
    static XJH_OneViewController *oneVC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        oneVC=[[self alloc]init];
    });
    return oneVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"one";
    self.view.me_backgroundColor=[UIColor me_colorPickerForMode:ViewBackgoundColor];
    //
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"归档" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"解归档" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction)];
    //
    
    UIButton *btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.width=100;
    btn.height=30;
    btn.x=self.view.width/2-btn.width/2;
    btn.y=self.view.height/2-btn.height/2;
    [btn setTitle:@"ToTwo" forState:(UIControlStateNormal)];
//    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.me_configKey=ButtonTypeColor;
    btn.me_backgroundColor=[UIColor me_colorPickerForMode:CharacterColor];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn bk_addEventHandler:^(id sender) {
        [[XJHTabBarController shareSingeleton] skipToOtherViewControllerWithTag:1];
        
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn];
    //
    UIButton *imageBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    imageBtn.frame=CGRectMake(20, 30, 100, 30);
    [imageBtn setTitle:@"相册(多选）" forState:(UIControlStateNormal)];
    [imageBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:imageBtn];
    imageBtn.backgroundColor=[UIColor blueColor];
    [imageBtn bk_addEventHandler:^(id sender) {
//        XJH_ImgaeViewController *imageVC=[XJH_ImgaeViewController new];
//        [self.navigationController pushViewController:imageVC animated:YES];
        [self showMXPickerWithMaximumPhotosAllow:9 completion:^(NSArray *assets) {
            NSLog(@"assets = %@", assets);
            NSMutableArray *array=[[NSMutableArray alloc]init];
            if (assets.count > 0) {
                for (int i=0; i<assets.count; i++) {
                    ALAsset *asset = assets[i];
                    
                    //全屏分辨率图片
                    UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                    NSLog(@"%@",image);
                    [array addObject:image];
                }
                [self setScrollViewWithImageArray:array];
                
                /*
                 //原始分辨率图片
                 CGFloat scale = asset.defaultRepresentation.scale;
                 UIImageOrientation orientation = (UIImageOrientation)asset.defaultRepresentation.orientation;
                 UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage scale:scale orientation:orientation];
                 */
                
            }
        }];
    } forControlEvents:(UIControlEventTouchUpInside)];
    //
    UIButton *imageBtn2=[UIButton buttonWithType:(UIButtonTypeCustom)];
    imageBtn2.frame=CGRectMake(20+CGRectGetMaxX(imageBtn.frame), 30, 100, 30);
    [imageBtn2 setTitle:@"相册(单选）" forState:(UIControlStateNormal)];
    [imageBtn2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:imageBtn2];
    imageBtn2.backgroundColor=[UIColor blueColor];
    [imageBtn2 bk_addEventHandler:^(id sender) {
        [self showMXPhotoPickerWithTitle:nil needToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
            [self setImageViewWithImage:image];
        }];
    } forControlEvents:(UIControlEventTouchUpInside)];
    //
    
    
}
-(void)setImageViewWithImage:(UIImage*)image{
    if(self.scrollView!=nil){
        [self.scrollView removeFromSuperview];
    }
    [self.imageView removeFromSuperview];
    self.imageView=[[UIImageView alloc]init];
    self.imageView.frame=CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width-20, 200);
    self.imageView.contentMode=UIViewContentModeScaleToFill;
    self.imageView.image=image;
    [self.view addSubview:self.imageView];
}
-(void)setScrollViewWithImageArray:(NSArray *)imageArray{
    if (self.imageView!=nil) {
        [self.imageView removeFromSuperview];
    }
    [self.scrollView removeFromSuperview];
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width-20, 200)];
    self.scrollView.contentSize=CGSizeMake(self.scrollView.bounds.size.width*imageArray.count, 0);
    self.scrollView.directionalLockEnabled=YES;
    self.scrollView.pagingEnabled=YES;
    for (int i=0; i<imageArray.count; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width*i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        imageV.image = imageArray[i];
        [self.scrollView addSubview:imageV];
    }
    [self.view addSubview:self.scrollView];
}
-(void)rightAction{
    NSLog(@"解归档");
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    path=[path stringByAppendingPathComponent:@"student"];
    NSLog(@"%@",path);
    //解归档
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@",arr);
}
-(void)leftAction{
    NSLog(@"归档");
    Student *stu1=[[Student alloc]init];
    stu1.name=@"张三胸";
    stu1.age=22;
    stu1.number=@"11051140123";
    Student *stu2=[[Student alloc]init];
    stu2.name=@"赵日天";
    stu2.age=23;
    stu2.number=@"11051140153";
    NSArray *arr=@[stu1,stu2];
    //获取当前应用的沙盒路径
    NSString *path=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    //追加一个路径
    path=[path stringByAppendingPathComponent:@"student"];
    [arr writeToFile:path atomically:YES];
    //归档
    [NSKeyedArchiver archiveRootObject:arr toFile:path];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[XJHTabBarController shareSingeleton] show];
    [self setHidesBottomBarWhenPushed:YES];
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
