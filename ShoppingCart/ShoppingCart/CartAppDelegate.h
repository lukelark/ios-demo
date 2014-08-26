//
//  CartAppDelegate.h
//  ShoppingCart
//
//  Created by chenjiang on 14-8-26.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void) insertDataIntoShoppingCartDB;
- (void) displayShoppingCart;

@end
