//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by chenjiang on 14-9-1.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "CandyTableViewController.h"
#import "CSCandy.h"

@interface CandyTableViewController ()

@end

@implementation CandyTableViewController

@synthesize candySearchBar;

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

  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (tableView == self.searchDisplayController.searchResultsTableView) {
    return _filteredCandyArray.count;
  }
  return _candyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"candycellid";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  CSCandy *candy = nil;
  if (tableView == self.searchDisplayController.searchResultsTableView) {
    candy = [_filteredCandyArray objectAtIndex:indexPath.row];
  }else{
    candy = [_candyArray objectAtIndex:indexPath.row];
  }
  cell.textLabel.text = candy.name;
  [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
  [self.filteredCandyArray removeAllObjects];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
  NSArray *tempArray = [NSMutableArray arrayWithArray:[_candyArray filteredArrayUsingPredicate:predicate]];
  
  if (![scope isEqualToString:@"all"]) {
    NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@", scope];
    tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
  }
  
  _filteredCandyArray = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
  [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
  return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
  [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
  return YES;
}



@end
