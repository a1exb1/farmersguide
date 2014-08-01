//
//  FarmadsDetailViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 01/08/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "FarmadsDetailViewController.h"

@interface FarmadsDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FarmadsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setNavigationPaneBarButtonItem:(UIBarButtonItem *)navigationPaneBarButtonItem
{
    self.navigationItem.leftBarButtonItems = nil;
    
    if (navigationPaneBarButtonItem != _navigationPaneBarButtonItem) {
        if (navigationPaneBarButtonItem)
            self.navigationItem.leftBarButtonItem = navigationPaneBarButtonItem;
        else
            self.navigationItem.leftBarButtonItem = nil;
        
        _navigationPaneBarButtonItem = navigationPaneBarButtonItem;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.title = @"Balers & Bale Handling (4 results)";
    
    if (_navigationPaneBarButtonItem)
        self.navigationItem.leftBarButtonItem = self.navigationPaneBarButtonItem;
    _cellsArray = [[NSMutableArray alloc] init];
    [_cellsArray addObject:@"Grain dryer, Alvin Blanch, 10/6 grain dryer, 10t, diesel burner, dual air flow, dismantled, sits on trailer, fully transportable."];
    [_cellsArray addObject:@"Talbot 150kw biomass boiler, fully automatic, c/w augers & 14cu/m hopper."];
    [_cellsArray addObject:@"Fyson 24' elevator, 3 phase, mounted on 4 wheel trailer, c/w 1t hopper. £1,900+VAT."];
    [_cellsArray addObject:@"Protimeter moisture meter, 1 at £50, 1 at £30, both ono."];
    [_cellsArray addObject:@"Grain dryer, Alvin Blanch, 10/6 grain dryer, 10t, diesel burner, dual air flow, dismantled, sits on trailer, fully transportable."];
    [_cellsArray addObject:@"Morridge batch grain dryer,10t, gas, has been used last 10yrs on 150 acres of crops, rape screens, in working order; also, bulk hopper available for bucket filling. Open to sensible offers."];
    [_cellsArray addObject:@"Ali corn bin, 20t, for outside purposes. Offers."];
    [_cellsArray addObject:@"Protimeter moisture meter, 1 at £50, 1 at £30, both ono."];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self updateViewConstraints];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_cellsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [_cellsArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"County: (N Yorks) - Name: RH Metcalfe - Tel: 01765 620640";
    
    if (indexPath.row == 2 || indexPath.row == 10) {
        NSURL *url = [[NSURL alloc] initWithString:@"http://www.farmersguide.co.uk/content/img/farmads/0039133_B.jpg"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        cell.imageView.image = image;
    }
    return cell;
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
