//
//  CSSearchBarTableViewController.m
//  CandySearch
//
//  Created by chenjiang on 14-9-1.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "CSSearchBarTableViewController.h"
#import "CSCandy.h"

@interface CSSearchBarTableViewController ()<UISearchBarDelegate, UISearchDisplayDelegate>

@property(nonatomic, strong) NSArray *candyArray;
@property(nonatomic, strong) NSMutableArray *filteredCandyArray;

/**
 *  搜索框
 */
@property(nonatomic, strong) UISearchBar *searchBar;

/**
 *  搜索框绑定的控制器
 */
@property(nonatomic) UISearchDisplayController *searchController;

/**
 *  根据搜索条件过滤tableview中的内容
 *
 *  @param searchText 搜索框中的内容
 *  @param scope      搜索范围
 */
- (void)filterContenForSearchText:(NSString*)searchText scope:(NSString *)scope;

@end

@implementation CSSearchBarTableViewController

- (void)filterContenForSearchText:(NSString *)searchText scope:(NSString *)scope
{
  [self.filteredCandyArray removeAllObjects];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
  NSArray *tempArray = [NSMutableArray arrayWithArray:[_candyArray filteredArrayUsingPredicate:predicate]];
  _filteredCandyArray = [NSMutableArray arrayWithArray:tempArray];
}

- (UISearchBar *)searchBar
{
  if (_searchBar == nil)
  {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    _searchBar.delegate = self;
    
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchController.delegate = self;
    _searchController.searchResultsDelegate = self;
    _searchController.searchResultsDataSource = self;
  }
  
  return _searchBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  _candyArray = [NSArray arrayWithObjects:
                 [CSCandy candyOfCategory:@"chocolate" name:@"chocolate bar"],
                 [CSCandy candyOfCategory:@"chocolate" name:@"chocolate chip"],
                 [CSCandy candyOfCategory:@"chocolate" name:@"dark chocolate"],
                 [CSCandy candyOfCategory:@"hard" name:@"lollipop"],
                 [CSCandy candyOfCategory:@"hard" name:@"candy cane"],
                 [CSCandy candyOfCategory:@"hard" name:@"jaw breaker"],
                 [CSCandy candyOfCategory:@"other" name:@"caramel"],
                 [CSCandy candyOfCategory:@"other" name:@"sour chew"],
                 [CSCandy candyOfCategory:@"other" name:@"peanut butter cup"],
                 [CSCandy candyOfCategory:@"other" name:@"gummi bear"], nil];
  
  self.filteredCandyArray = [NSMutableArray arrayWithCapacity:_candyArray.count];
  
  self.tableView.tableHeaderView = self.searchBar;
  
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (tableView == _searchController.searchResultsTableView) {
    return _filteredCandyArray.count;
  }
  return _candyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = @"cellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  CSCandy *candy = nil;
  if (tableView == _searchController.searchResultsTableView) {
    candy = [_filteredCandyArray objectAtIndex:indexPath.row];
  }else{
    candy = [_candyArray objectAtIndex:indexPath.row];
  }
  cell.textLabel.text = candy.name;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  return cell;
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
  [self filterContenForSearchText:searchString scope:[[_searchBar scopeButtonTitles] objectAtIndex:[_searchBar selectedScopeButtonIndex]]];
  return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
  [self filterContenForSearchText:self.searchDisplayController.searchBar.text scope:[[_searchBar scopeButtonTitles] objectAtIndex:searchOption]];
  return YES;
}

@end
