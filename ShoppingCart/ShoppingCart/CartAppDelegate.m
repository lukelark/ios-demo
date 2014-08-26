//
//  CartAppDelegate.m
//  ShoppingCart
//
//  Created by chenjiang on 14-8-26.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "CartAppDelegate.h"
#import "Customer.h"
#import "ShoppingCartDetail.h"
#import "ShoppingCartMaster.h"

@implementation CartAppDelegate

@synthesize managedObjectContext = _managedObjectContext;

- (void)insertDataIntoShoppingCartDB
{
  Customer *customer1 = (Customer*)[NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:self.managedObjectContext];
  customer1.customerID = [NSNumber numberWithInt:1];
  customer1.customerName = @"陈江";
  customer1.password = @"chenjiang";
  customer1.userName = @"chenjiangusername";
  
  ShoppingCartMaster *shoppingCartMaster1 = (ShoppingCartMaster*)[NSEntityDescription insertNewObjectForEntityForName:@"ShoppingCartMaster" inManagedObjectContext:self.managedObjectContext];
  shoppingCartMaster1.cartID = [NSNumber numberWithInt:1];
  shoppingCartMaster1.customerID = [NSNumber numberWithInt:1];
  
  ShoppingCartDetail *shoppingCartDetail1 = (ShoppingCartDetail*)[NSEntityDescription insertNewObjectForEntityForName:@"ShoppingCartDetail" inManagedObjectContext:self.managedObjectContext];
  shoppingCartDetail1.cartID = [NSNumber numberWithInt:1];
  shoppingCartDetail1.currentPrice = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:18.5f] decimalValue]];
  shoppingCartDetail1.productID = @"1-11-11";
  shoppingCartDetail1.productName = @"猪肉";
  shoppingCartDetail1.productSysNo = [NSNumber numberWithInt:10];
  
  ShoppingCartDetail *shoppingCartDetail2 = (ShoppingCartDetail*)[NSEntityDescription insertNewObjectForEntityForName:@"ShoppingCartDetail" inManagedObjectContext:self.managedObjectContext];
  shoppingCartDetail2.cartID = [NSNumber numberWithInt:100];
  shoppingCartDetail2.currentPrice = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:18.5f] decimalValue]];
  shoppingCartDetail2.productID = @"2-22-22";
  shoppingCartDetail2.productName = @"牛肉";
  shoppingCartDetail2.productSysNo = [NSNumber numberWithInt:10];
  
  customer1.cart = shoppingCartMaster1;
  [shoppingCartMaster1 addDetailObject:shoppingCartDetail1];
  [shoppingCartMaster1 addDetailObject:shoppingCartDetail2];
  
  if ([self.managedObjectContext hasChanges])
  {
    [self.managedObjectContext save:nil];
  }
}

- (void)displayShoppingCart
{
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *myEntityQuert = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.managedObjectContext];
  [request setEntity:myEntityQuert];
  NSError *error = nil;
  NSArray *customerArr = [self.managedObjectContext executeFetchRequest:request error:&error];
  NSInteger recordCount = [customerArr count];
  NSLog(@"Record count : %d", recordCount);
  
  for (int i = 0; i < recordCount; i++)
  {
    Customer *customer = [customerArr objectAtIndex:i];
    NSLog(@"customerName: %@", customer.customerName);
    
    ShoppingCartMaster *cart = (ShoppingCartMaster*)customer.cart;
    NSLog(@"我的购物车：%@", cart.cartID);
    
    NSArray *productList = [cart.detail allObjects];
    int numberofProducts = [productList count];
    NSLog(@"购物车商品数：%d", numberofProducts);
    
    for(int i = 0; i < numberofProducts; i++)
    {
      ShoppingCartDetail *detail = [productList objectAtIndex:i];
      NSLog(@"购物车商品：%@", detail.productName);
    }
  }
}

- (NSManagedObjectContext *)managedObjectContext
{
  if (_managedObjectContext == nil)
  {
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeDataBaseUrl = [url URLByAppendingPathComponent:@"ShoppingCart.sqlite"];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeDataBaseUrl options:nil error:&error])
    {
      NSLog(@"Error while loading persistent store ... %@", error);
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
  }
  
  return _managedObjectContext;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
  [self insertDataIntoShoppingCartDB];
  [self displayShoppingCart];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
