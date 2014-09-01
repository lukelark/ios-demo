//
//  CSCandy.h
//  CandySearch
//
//  Created by chenjiang on 14-9-1.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCandy : NSObject

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+ (id)candyOfCategory:(NSString *)category name:(NSString*)name;

@end
