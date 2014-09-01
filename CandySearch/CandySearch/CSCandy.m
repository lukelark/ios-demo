//
//  CSCandy.m
//  CandySearch
//
//  Created by chenjiang on 14-9-1.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "CSCandy.h"

@implementation CSCandy

+ (id)candyOfCategory:(NSString *)category name:(NSString *)name
{
  return [[CSCandy alloc] initWithCategory:category name:name];
}

- (id)initWithCategory:(NSString *)category name:(NSString *)name
{
  if (self = [super init]) {
    _category = category;
    _name = name;
  }
  return self;
}

@end
