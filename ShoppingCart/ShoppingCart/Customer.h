//
//  Customer.h
//  ShoppingCart
//
//  Created by chenjiang on 14-8-26.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Customer : NSManagedObject

@property (nonatomic, retain) NSNumber * customerID;
@property (nonatomic, retain) NSString * customerName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSManagedObject *cart;

@end
