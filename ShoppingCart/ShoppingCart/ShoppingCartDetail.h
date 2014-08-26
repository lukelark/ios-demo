//
//  ShoppingCartDetail.h
//  ShoppingCart
//
//  Created by chenjiang on 14-8-26.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ShoppingCartDetail : NSManagedObject

@property (nonatomic, retain) NSNumber * cartID;
@property (nonatomic, retain) NSDecimalNumber * currentPrice;
@property (nonatomic, retain) NSNumber * customerID;
@property (nonatomic, retain) NSString * productID;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * productSysNo;
@property (nonatomic, retain) NSManagedObject *master;

@end
