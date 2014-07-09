//
//  ArticlesTableViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 09/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "ArticlesTableViewController.h"

@interface ArticlesTableViewController ()

@end

@implementation ArticlesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cells = [[NSMutableArray alloc] init];
    self.title = _categoryName;
    [self refresh];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        // append data to data source, insert new cells at the end of table view
        // call [tableView.infiniteScrollingView stopAnimating] when done
        jsonReader *reader = [[jsonReader alloc] init];
        reader.delegate = (id)weakSelf;
        reader.task = @"add";
        NSString *url = [NSString stringWithFormat:@"http://www.bechmann.co.uk/fg/GetJSData.aspx?dt=CategoryArticles&id=%li&start=%lu&rows=20", weakSelf.categoryID, (unsigned long)([weakSelf.cells count])];
        [reader jsonAsyncRequestWithDelegateAndUrl:url];
    }];
    
    
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf refresh];
//    }];
}

//- (void)scrollViewDidScroll: (UIScrollView*)scrollView {
//    
//    NSInteger currentOffset = scrollView.contentOffset.y;
//    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
//
//    if ((currentOffset > 0) && (maximumOffset - currentOffset) <= 10) {
//        [self loadMore];
//    }
//
//}

-(void)loadMore
{
    jsonReader *reader = [[jsonReader alloc] init];
    reader.delegate = (id)self;
    reader.task = @"add";
    NSString *url = [NSString stringWithFormat:@"http://www.bechmann.co.uk/fg/GetJSData.aspx?dt=CategoryArticles&id=%li&start=%lu&rows=20", self.categoryID, (unsigned long)([self.cells count])];
    [reader jsonAsyncRequestWithDelegateAndUrl:url];
}

-(void)refresh
{
    _cells = [[NSMutableArray alloc] init];
    //[self.refreshControl beginRefreshing];
    jsonReader *reader = [[jsonReader alloc] init];
    reader.delegate = (id)self;
    reader.task = @"refresh";
    NSString *url = [NSString stringWithFormat:@"http://www.bechmann.co.uk/fg/GetJSData.aspx?dt=CategoryArticles&id=%li&start=%lu&rows=20", _categoryID, (unsigned long)([_cells count])];
    [reader jsonAsyncRequestWithDelegateAndUrl:url];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_cells count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSDictionary *category = [_cells objectAtIndex:indexPath.row];
    cell.textLabel.text = [category objectForKey:@"Title"];
    //cell.detailTextLabel.text = [category objectForKey:@"Title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void) finished:(NSString *)task withArray:(NSArray *)array andReader:(jsonReader*)reader
{
    [self.refreshControl endRefreshing];
    [self.tableView.infiniteScrollingView stopAnimating];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:array];
    
    if([reader.task isEqualToString:@"refresh"])
        [self refreshFromArray:arr];
    
    else if([reader.task isEqualToString:@"add"])
            [self addToArray:arr];
    
    [self.tableView reloadData];
}

-(void)refreshFromArray: (NSMutableArray*)arr
{
    _cells = arr;
}

-(void)addToArray: (NSMutableArray*)arr
{
    for (id object in arr){
        [_cells addObject:object];
    }
}

@end
