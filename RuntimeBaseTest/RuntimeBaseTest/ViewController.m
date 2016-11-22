//
//  ViewController.m
//  RuntimeBaseTest
//
//  Created by HYG_IOS on 2016/11/21.
//  Copyright © 2016年 magic. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ViewController ()<PersonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self test1];//获取成员变量
    [self test2];//获取属性
    [self test3];//获取方法
    [self test4];//获取delegate
    [self test5];//综合案例(归档-解档)
}
- (void)test1
{
    unsigned int count;
    Ivar * ivars = class_copyIvarList([Person class], &count);
    for (int i=0; i <count; i ++) {
        Ivar ivar = ivars[i];
        const char * str = ivar_getName(ivar);
        ZGLog(@"%@",[NSString stringWithUTF8String:str]);
    }
    free(ivars);
}
- (void)test2
{
    unsigned int count;
    objc_property_t * propertys = class_copyPropertyList([Person class], &count);
    for (int i= 0; i < count; i ++) {
        objc_property_t property = propertys[i];
        const char * str = property_getName(property);
        ZGLog(@"%@",[NSString stringWithUTF8String:str]);
    }
    free(propertys);
}
- (void)test3
{
    unsigned int count;
    Method * methods = class_copyMethodList([Person class], &count);
    for (int i = 0; i < count; i ++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        const char * str = sel_getName(sel);
        ZGLog(@"%@",[NSString stringWithUTF8String:str]);
    }
}
- (void)test4
{
    unsigned int count;
    __unsafe_unretained Protocol ** protocols = class_copyProtocolList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Protocol * protocol = protocols[i];
        const char * str = protocol_getName(protocol);
        ZGLog(@"%@",[NSString stringWithUTF8String:str]);
    }
}
- (void)test5
{
    Person * xiaoming = [[Person alloc]init];
    xiaoming.age = @"12";
    xiaoming.name = @"xiaoming";
    xiaoming.score = @"99";
    xiaoming.height = @"185.0";
    
    NSString * path = [NSString stringWithFormat:@"%@/archiver",NSHomeDirectory()];
    [NSKeyedArchiver archiveRootObject:xiaoming toFile:path];
    
    Person * per = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    ZGLog(@"%@-%@",path,per);
    
}
- (void)thisIsPersonDelegateMethod
{}
@end
