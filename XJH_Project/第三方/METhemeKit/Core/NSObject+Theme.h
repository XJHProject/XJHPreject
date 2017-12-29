//
//  NSObject+Theme.h
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id _Nullable (^MEPicker)(void);

@interface NSObject (Theme)
@property (nonatomic, strong, nonnull,readonly) NSMutableDictionary<NSString *, MEPicker> *pickers;

- (void)removePickerForSEL:(nullable SEL)selector;
@end
