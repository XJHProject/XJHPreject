//
//  Student.m
//  XJH_Project
//
//  Created by 熊进辉 on 16/9/5.
//  Copyright © 2016年 熊进辉. All rights reserved.
//

#import "Student.h"
static Student *singleton=nil;
@implementation Student
//序列化
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:@(self.age) forKey:@"age"];
    [aCoder encodeObject:self.number forKey:@"number"];
}
//反序列化
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ((self=[super init])) {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.age=[[aDecoder decodeObjectForKey:@"age"] integerValue];
        self.number=[aDecoder decodeObjectForKey:@"number"];
    }
    return self;

}
-(NSString *)description{
    return [NSString stringWithFormat:@"name:%@;age:%ld;number:%@",_name,_age,_number];
}
//单例
+(Student *)shared{
    //多线程操作时锁定此操作，避免多处同时创建对象，导致单一实例失败
    @synchronized (singleton) {
        if (singleton==nil) {
            singleton=[[self alloc] initPrivate];
        }
    }
    return singleton;
}
-(instancetype)initPrivate{
    if (self==[super init]) {
        
    }
    return self;
}
@end
