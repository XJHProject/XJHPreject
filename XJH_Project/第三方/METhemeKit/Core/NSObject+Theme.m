//
//  NSObject+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "NSObject+Theme.h"
#import "ThemeProperties.h"
#import "NSObject+DeallocBlock.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSObject (Theme)
- (void)removePickerForSEL:(SEL)selector{
    NSString *key = NSStringFromSelector(selector);
    [self.pickers removeObjectForKey:key];
}

-(NSMutableDictionary<NSString *,MEPicker> *)pickers{
    NSMutableDictionary<NSString *,MEPicker> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        //获取数组的时候进行初始化操作，同时进行通知的注册
        
        pickers = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        //初始化的时候添加通知
        __weak typeof(self) weakSelf = self;
        __weak id notificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kMEThemeChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [weakSelf changeTheme];
        }];
        if (self.deallocHelperExecutor == nil) {
            //这里添加一个属性，监听控件的dealloc事件，进行通知的移除
            MEDeallocBlockExecutor *deallocHelper = [[MEDeallocBlockExecutor alloc]initWith:^{
                [[NSNotificationCenter defaultCenter] removeObserver:notificationObserver];
            }];
            self.deallocHelperExecutor = deallocHelper;
        }
    }
    return pickers;
}
- (void)changeTheme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, MEPicker  _Nonnull obj, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(key);
        id result = obj();
        [UIView animateWithDuration:METhemeAnimationDuration animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if ([self respondsToSelector:sel]) {
                [self performSelector:sel withObject:result];
            }
#pragma clang diagnostic pop
        }];
        
    }];
}
@end
