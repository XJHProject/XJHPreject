//
//  MEDeallocBlockExecutor.m
//  METhemeKit
//
//  Created by Yasin on 16/3/7.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MEDeallocBlockExecutor.h"
@interface MEDeallocBlockExecutor()
@property (nonatomic, copy) DeallocBlock deallocBlock;
@end
@implementation MEDeallocBlockExecutor
- (instancetype)initWith:(DeallocBlock)deallocBlock{
    self = [super init];
    if (self) {
        self.deallocBlock = deallocBlock;
    }
    return self;
}
-(void)dealloc{
    if (self.deallocBlock) {
        self.deallocBlock();
        self.deallocBlock = nil;
    }
}
@end
