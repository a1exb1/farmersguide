//
//  ArticleCategoriesTableViewController.h
//  Farmers Guide
//
//  Created by Alex Bechmann on 09/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleViewController.h"
#import "ArticlesTableViewController.h"
#import "jsonReader.h"
#import "Tools.h"

@interface ArticleCategoriesTableViewController : UITableViewController

@property NSArray *cellsArray;
@property NSMutableArray *section2Array;

-(IBAction)refresh;

@end
