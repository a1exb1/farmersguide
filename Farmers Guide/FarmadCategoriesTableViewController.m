//
//  FarmadCategoriesTableViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 01/08/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "FarmadCategoriesTableViewController.h"

@interface FarmadCategoriesTableViewController ()

@end

@implementation FarmadCategoriesTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _cellsArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *section = [[NSMutableArray alloc] init];
    [section addObject:@"ATVs/UTVs"];
    [section addObject:@"Balers & Bale Handling"];
    [section addObject:@"Beet Equiptment"];
    [section addObject:@"Boiler Plant, Heating & Ovens"];
    [section addObject:@"Trailers"];
    [_cellsArray addObject:section];
    
    section = [[NSMutableArray alloc] init];
    [section addObject:@"Potato Equipment"];
    [section addObject:@"Ploughs"];
    [section addObject:@"Beet Equiptment"];
    [_cellsArray addObject:section];
    
    [_cellsArray addObject:section];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[_cellsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = @"2";
            break;
            
        case 1:
            cell.detailTextLabel.text = @"8";
            break;
            
        case 2:
            cell.detailTextLabel.text = @"29";
            break;
            
        case 3:
            cell.detailTextLabel.text = @"7";
            break;
            
        default:
            cell.detailTextLabel.text = @"";
            break;
    }
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return @"Machinery";
            break;
            
        default:
            return @"Farming";
            break;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //FarmadCategoriesTableViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"farmads"];
    //[self.navigationController pushViewController:view animated:YES];
    
    DetailViewManager *manager = (DetailViewManager*)self.splitViewController.delegate;
    FarmadsDetailViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"farmadsDetail"];
    manager.detailViewController = view;
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
