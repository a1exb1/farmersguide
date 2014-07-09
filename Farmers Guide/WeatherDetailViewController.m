//
//  WeatherDetailViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 09/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "WeatherDetailViewController.h"

@interface WeatherDetailViewController ()

@end

@implementation WeatherDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_navigationPaneBarButtonItem)
        self.navigationItem.leftBarButtonItem = self.navigationPaneBarButtonItem;
    
    self.title = @"Weather";
}

- (void)setNavigationPaneBarButtonItem:(UIBarButtonItem *)navigationPaneBarButtonItem
{
    if (navigationPaneBarButtonItem != _navigationPaneBarButtonItem) {
        if (navigationPaneBarButtonItem)
            self.navigationItem.leftBarButtonItem = navigationPaneBarButtonItem;
        else
            self.navigationItem.leftBarButtonItem = nil;
        
        _navigationPaneBarButtonItem = navigationPaneBarButtonItem;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
