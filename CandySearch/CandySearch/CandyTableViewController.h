//
//  CandyTableViewController.h
//  CandySearch
//
//  Created by chenjiang on 14-9-1.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyTableViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property(nonatomic, strong) NSArray *candyArray;

@property(nonatomic, strong) NSMutableArray *filteredCandyArray;
@property(nonatomic, strong) IBOutlet UISearchBar *candySearchBar;

@end
