//
//  XJH_ImgaeViewController.m
//  XJH_Project
//
//  Created by 熊进辉 on 17/3/1.
//  Copyright © 2017年 熊进辉. All rights reserved.
//

#import "XJH_ImgaeViewController.h"
#import "XJHTabBarController.h"
#import "DNImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "DNAsset.h"
#import "NSURL+DNIMagePickerUrlEqual.h"

@interface XJH_ImgaeViewController ()<DNImagePickerControllerDelegate>

@end

@implementation XJH_ImgaeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择照片";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"选择照片" style:(UIBarButtonItemStylePlain) target:self action:@selector(selectImageAction)];
    
    // Do any additional setup after loading the view.
}
-(void)selectImageAction{
    DNImagePickerController *imagePicker=[[DNImagePickerController alloc]init];
    imagePicker.imagePickerDelegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHidesBottomBarWhenPushed:YES];
    [[XJHTabBarController shareSingeleton] hide];
}
#pragma mark delegate
-(void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker{
   [imagePicker dismissViewControllerAnimated:YES completion:^{
       NSLog(@"取消");
   }];
}
-(void)dnImagePickerController:(DNImagePickerController *)imagePicker sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage{
    NSLog(@"图片数组:%@",imageAssets);
    NSLog(@"状态：%d",fullImage);
}
-(void)getImageArrayWithArray:(NSArray *)array withFullImage:(BOOL)full{
    for (int i=0; i<array.count; i++) {
        DNAsset *dnasset=array[i];
        
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
