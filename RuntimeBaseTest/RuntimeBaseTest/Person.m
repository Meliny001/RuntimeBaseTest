//
//  Person.m
//  RuntimeBaseTest
//
//  Created by HYG_IOS on 2016/11/21.
//  Copyright © 2016年 magic. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person ()<NSCoding>

@end

@implementation Person

- (void)eat
{
    ZGLog(@"");
}
- (void)sleep
{
    ZGLog(@"");
}
- (void)run
{
    ZGLog(@"");
}
- (void)study
{
    ZGLog(@"");
}

/**
 归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count;
    objc_property_t * propertys = class_copyPropertyList([self class], &count);
    for (int i = 0; i <count; i ++) {
        objc_property_t property = propertys[i];
        const char * str = property_getName(property);
        NSString * key = [NSString stringWithUTF8String:str];
        NSString * value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(propertys);
}

/**
 解档
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    unsigned int count;
    objc_property_t * propertys = class_copyPropertyList([self class], &count);
    for (int i = 0 ; i < count; i ++) {
        objc_property_t property = propertys[i];
        NSString * key = [NSString stringWithUTF8String:property_getName(property)];
        NSString * value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(propertys);
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"age:%@,name:%@,score:%@,height:%@",_age,_name,_score,_height];
}
@end
