//
//  moreTableViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 11/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "moreTableViewController.h"

@interface moreTableViewController ()

@end

@implementation moreTableViewController

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
    [self setCellsArr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCellsArr
{
    _cellsArray = [[NSMutableArray alloc] init];
    NSMutableArray *section =[[NSMutableArray alloc ]init];
    
    //SECTION
    NSArray *cell = [[NSArray alloc]initWithObjects:@"", @"Advertise", @"", @"advertise", nil];
    [section addObject:cell];
    
    //    cell = [[NSArray alloc]initWithObjects:@"Calendar-Date-03-80.png", @"Calender", @"", @"calender", nil];
    //    [section addObject:cell];
    cell = [[NSArray alloc]initWithObjects:@"", @"Subscribe to magazine", @"", @"subscribe", nil];
    [section addObject:cell];
    
    
    cell = [[NSArray alloc]initWithObjects:@"", @"Diary dates", @"", @"diary", nil];
    [section addObject:cell];
    
    cell = [[NSArray alloc]initWithObjects:@"", @"Read the magazine", @"", @"magazine", nil];
    [section addObject:cell];
    
    [_cellsArray addObject:section];
    
    
    //SECTION
//    section =[[NSMutableArray alloc ]init];
//    cell = [[NSArray alloc]initWithObjects:@"602-exit.png", @"Logout", @"", @"logout", nil];
//    [section addObject:cell];
//    [_cellsArray addObject:section];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_cellsArray count];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
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
    
    cell.accessibilityValue = [[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 3];
    
    cell.detailTextLabel.text = [[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 2];

    
    cell.imageView.image = [UIImage imageNamed:[[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 0]];
    
    cell.textLabel.text = [[[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row] objectAtIndex: 1];
    
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *cellArray = [[_cellsArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row];
    if ([[cellArray objectAtIndex:3] isEqualToString:@"magazine"]) {
        //
        magazineReaderViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"magazineReader"];
        
        DetailViewManager *detailViewManager = (DetailViewManager*)self.splitViewController.delegate;

        detailViewManager.detailViewController = view;
        
    }
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
