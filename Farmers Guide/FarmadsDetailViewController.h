//
//  FarmadsDetailViewController.h
//  Farmers Guide
//
//  Created by Alex Bechmann on 01/08/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewManager.h"

@interface FarmadsDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SubstitutableDetailViewController>

@property (nonatomic, strong) UIBarButtonItem *navigationPaneBarButtonItem;
@property NSMutableArray *cellsArray;

@end
