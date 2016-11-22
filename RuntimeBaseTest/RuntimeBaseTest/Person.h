//
//  Person.h
//  RuntimeBaseTest
//
//  Created by HYG_IOS on 2016/11/21.
//  Copyright © 2016年 magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonDelegate <NSObject>

- (void)thisIsPersonDelegateMethod;

@end

@interface Person : NSObject

@property(nonatomic, copy) NSString * age;
@property(nonatomic, copy) NSString * name;
@property(nonatomic, copy) NSString * score;
@property(nonatomic, copy) NSString * height;
@property(nonatomic, weak) id<PersonDelegate>delegate;

- (void)eat;
- (void)sleep;
- (void)run;
- (void)study;

@end
