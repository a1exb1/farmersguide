//
//  ArticlesTableViewController.h
//  Farmers Guide
//
//  Created by Alex Bechmann on 09/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jsonReader.h"
#import "SVPullToRefresh.h"

@interface ArticlesTableViewController : UITableViewController

@property long categoryID;
@property NSString *categoryName;
@property long loadedArticles;
@property NSMutableArray *cells;
@property bool shouldScroll;

-(IBAction)refresh;

@end
