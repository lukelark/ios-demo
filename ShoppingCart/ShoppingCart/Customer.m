//
//  Customer.m
//  ShoppingCart
//
//  Created by chenjiang on 14-8-26.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "Customer.h"


@implementation Customer

//@dynamic 是相对于 @synthesize的，它们用样用于修饰 @property，用于生成对应的的getter和setter方法。但是@ dynamic表示这个成员变量的getter和setter方法并不是直接由编译器生成，而是手工生成或者运行时生成。
@dynamic customerID;
@dynamic customerName;
@dynamic password;
@dynamic userName;
@dynamic cart;

@end
