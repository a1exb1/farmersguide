//
//  ArticleViewController.h
//  Farmers Guide
//
//  Created by Alex Bechmann on 09/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewManager.h"

@interface ArticleViewController : UIViewController <SubstitutableDetailViewController, UIWebViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *navigationPaneBarButtonItem;
@property long articleID;
@property NSString *articleTitle;
@property UIImageView *adView;

@end
