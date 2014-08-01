//
//  ArticleCategoriesTableViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 09/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "ArticleCategoriesTableViewController.h"

@interface ArticleCategoriesTableViewController ()

@end

@implementation ArticleCategoriesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    //DetailViewManager *detailViewManager = (DetailViewManager*)self.splitViewController.delegate;
    //ArticleViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Article"];
    //detailViewManager.detailViewController = view;
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
    
    
    if (!_loaded) {
        [self refresh];
        _loaded = YES;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    _section2Array = [[NSMutableArray alloc] init];
    
    //SECTION
    UIImage *img = [UIImage imageNamed:@"726-star-toolbar-selected"];
    img = [Tools colorAnImage:[UIColor yellowColor]: img];
    NSArray *cell = [[NSArray alloc]initWithObjects:img, @"Favourites", @"", @"favourites", nil];
    [_section2Array addObject:cell];
    
    //new section
    //_section3Array = [[NSMutableArray alloc] init];
    
    //twitter
    img = [UIImage imageNamed:@"twitter.png"];
    cell = [[NSArray alloc]initWithObjects:img, @"Twitter", @"", @"twitter", nil];
    [_section2Array addObject:cell];
    
    //read magazine
    cell = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"874-newspaper.png"], @"Read the magazine", @"", @"magazine", nil];
    [_section2Array addObject:cell];
    
    [self.navigationController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"874-newspaper-selected.png"] imageWithRenderingMode:UIImageRenderingModeAutomatic]];
}

-(void)refresh
{
    //[self.refreshControl beginRefreshing];
    if (!_loaded)
        [Tools showLightLoaderWithView:self.view];
    
    jsonReader *reader = [[jsonReader alloc] init];
    reader.delegate = (id)self;
    [reader jsonAsyncRequestWithDelegateAndUrl:@"http://www.bechmann.co.uk/fg/GetJSData.aspx?dt=Categories&id=1"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_cellsArray count];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_cellsArray objectAtIndex:section ] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
   
    if(indexPath.section == 0){
        NSDictionary *category = [[_cellsArray objectAtIndex:0] objectAtIndex:indexPath.row];
        cell.textLabel.text = [category objectForKey:@"Category"];
    }
    else{
        cell.accessibilityValue = [[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 3];
        cell.detailTextLabel.text = [[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 2];
        cell.imageView.image = [[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 0];
        cell.textLabel.text = [[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 1];

    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSDictionary *category = [[_cellsArray objectAtIndex:0] objectAtIndex:indexPath.row];
        
        ArticlesTableViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Articles"];
        view.categoryID = [[category objectForKey:@"CategoryID"] intValue];
        view.categoryName = [category objectForKey:@"Category"];
        [self.navigationController pushViewController:view animated:YES];
    }
    
    if (indexPath.section == 1) {
        NSArray *item = [[_cellsArray objectAtIndex:1] objectAtIndex:indexPath.row];
        
        DetailViewManager *detailViewManager = (DetailViewManager*)self.splitViewController.delegate;
        
        if (indexPath.row == 0) {
            
        }
        
        if ([[item objectAtIndex:3]isEqualToString:@"magazine"]) {
            
            magazineReaderViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"magazineReader"];
            
            view.title = @"Farmers Guide Issue #337";
            view.urlString = @"http://www.newforests.net/wp-content/uploads/2011/01/sample_pdf.pdf";

            detailViewManager.detailViewController = view;
        }
        
        if ([[item objectAtIndex:3]isEqualToString:@"twitter"]) {
            
            magazineReaderViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"magazineReader"];
            view.urlString = @"https://twitter.com/farmersguide";
            view.title = @"Twitter: #farmersguide";
            detailViewManager.detailViewController = view;
        }
    }
}

- (void) finished:(NSString *)task withArray:(NSArray *)array andReader:(jsonReader*)reader
{
    _cellsArray = [[NSArray alloc] initWithObjects:array, _section2Array, nil];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    [Tools hideLoaderFromView:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
