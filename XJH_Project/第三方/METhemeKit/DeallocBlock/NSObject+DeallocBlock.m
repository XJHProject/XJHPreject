//
//  NSObject+DeallocBlock.m
//  METhemeKit
//
//  Created by Yasin on 16/3/7.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "NSObject+DeallocBlock.h"
#import <objc/runtime.h>
@implementation NSObject (DeallocBlock)
- (MEDeallocBlockExecutor *)deallocHelperExecutor{
    return objc_getAssociatedObject(self, @selector(deallocHelperExecutor));
}
- (void)setDeallocHelperExecutor:(MEDeallocBlockExecutor *)deallocHelperExecutor{
    objc_setAssociatedObject(self, @selector(deallocHelperExecutor), deallocHelperExecutor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
