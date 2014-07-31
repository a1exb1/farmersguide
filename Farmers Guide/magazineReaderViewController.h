//
//  magazineReaderViewController.h
//  Farmers Guide
//
//  Created by Alex Bechmann on 31/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewManager.h"
#import "Tools.h"

@interface magazineReaderViewController : UIViewController <SubstitutableDetailViewController, UIWebViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *navigationPaneBarButtonItem;
@property NSString *urlString;


@end
