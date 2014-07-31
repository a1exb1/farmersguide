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

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cells = [[NSMutableArray alloc] init];
    self.title = _categoryName;
    [self refresh];
    
    //UIView *loader = self.tableView.infiniteScrollingView.vi
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        // append data to data source, insert new cells at the end of table view
        // call [tableView.infiniteScrollingView stopAnimating] when done
        if (weakSelf.shouldScroll) {
            weakSelf.tableView.infiniteScrollingView.hidden = NO;
            jsonReader *reader = [[jsonReader alloc] init];
            reader.delegate = (id)weakSelf;
            reader.task = @"add";
            NSString *url = [NSString stringWithFormat:@"http://www.bechmann.co.uk/fg/GetJSData.aspx?dt=CategoryArticles&id=%li&start=%lu&rows=20", weakSelf.categoryID, ((unsigned long)([weakSelf.cells count]) + 1)];
            [reader jsonAsyncRequestWithDelegateAndUrl:url];
        }
        else{
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
        }
    }];
    
    _images = [[NSMutableArray alloc] init];
}

- (void)scrollViewDidScroll: (UIScrollView*)scrollView {
    
    NSInteger currentOffset = scrollView.contentOffset.y;
    //NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if(currentOffset > -64){
        for (UIView *view in self.tableView.infiniteScrollingView.subviews)
        {
            view.hidden = NO;
        }
        _shouldScroll = YES;
    }
    else{
        for (UIView *view in self.tableView.infiniteScrollingView.subviews)
        {
            view.hidden = YES;
        }
        _shouldScroll = NO;
    }    
}

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
    //customCell *cell = [[customCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    customCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if([_cells count] >= indexPath.row ){
        NSDictionary *category = [_cells objectAtIndex:indexPath.row]; // crash here  [__NSArrayM objectAtIndex:]: index 15 beyond bounds for empty array'

        //NSString *url = [NSString stringWithFormat:@"http://www.farmersguide.co.uk/content/img/thumbs/%@", [category objectForKey:@"Thumbnail"]];
        //cell.imageView.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        
        cell.BMImageView.image = nil;
        for (NSDictionary *d in _images)
        {
            if([d valueForKey:[category objectForKey:@"ArticleID"]] != nil)
            {
                cell.BMImageView.image = [d objectForKey:[category objectForKey:@"ArticleID"]];
            }
        }
        
        cell.BMTitle.text = [category objectForKey:@"Title"];
        cell.BMArticlePreview.text = [category objectForKey:@"Title"];
        [cell.BMArticlePreview setUserInteractionEnabled:NO];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

- (void) finished:(NSString *)task withArray:(NSArray *)array andReader:(jsonReader*)reader
{
    [self.refreshControl endRefreshing];
    [self.tableView.infiniteScrollingView stopAnimating];
    self.tableView.infiniteScrollingView.hidden = YES;
    for (UIView *view in self.tableView.infiniteScrollingView.subviews)
    {
        view.hidden = YES;
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:array];
    
    if([reader.task isEqualToString:@"refresh"])
        [self refreshFromArray:arr];
    
    else if([reader.task isEqualToString:@"add"])
        [self addToArray:arr];
    
    [self.tableView reloadData];
    [self loadImages];
}

-(void)refreshFromArray: (NSMutableArray*)arr
{
    _cells = [[NSMutableArray alloc] init];
    _cells = arr;
}

-(void)addToArray: (NSMutableArray*)arr
{
    for (id object in arr){
        [_cells addObject:object];
    }
}

-(void)loadImages
{
    for (NSMutableDictionary *obj in _cells)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://www.farmersguide.co.uk/content/img/thumbs/%@", [obj objectForKey:@"Thumbnail"]];
        NSURL *url = [NSURL URLWithString: urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
            
            NSData *imgData = data;
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        NSString *key = [NSString stringWithFormat:@"%@", [obj objectForKey:@"ArticleID"]];
                        dict[key] = image;
                        [_images addObject:dict];
                        //NSString *hasObj = @"true";
                        //obj[@"hasImg"] = hasObj;
                        [self.tableView reloadData];
                    });
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[_delegate finished:@"load" withArray:arr];
            });
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *article = [_cells objectAtIndex:indexPath.row];
    
    DetailViewManager *detailViewManager = (DetailViewManager*)self.splitViewController.delegate;
    ArticleViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Article"];
    view.articleID = [[article objectForKey:@"ArticleID"] intValue];
    view.articleTitle = [article objectForKey:@"Title"];
    detailViewManager.detailViewController = view;
}

@end
