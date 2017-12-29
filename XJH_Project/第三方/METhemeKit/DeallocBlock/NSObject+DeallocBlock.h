//
//  NSObject+DeallocBlock.h
//  METhemeKit
//
//  Created by Yasin on 16/3/7.
//  Copyright © 2016年 Yasin. All rights reserved.
//

/**
 *  给主题NSObject扩展添加一个MEDeallocBlockExecutor成员变量，在NSObject释放内存的时候，
    deallocHelperExecutor也会释放，deallocHelperExecutor释放的时候会调用回调注销通知
 *
 */
#import <Foundation/Foundation.h>
#import "MEDeallocBlockExecutor.h"
@interface NSObject (DeallocBlock)
/**
 *  deallocHelperExecutor是一个继承于NSObject的类，主要作用就是使用它的dealloc事件移除通知
 */
@property (nonatomic, strong)MEDeallocBlockExecutor *deallocHelperExecutor;

@end
