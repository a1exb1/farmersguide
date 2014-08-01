//
//  ArticleViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 09/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "ArticleViewController.h"
#import "Tools.h"

@interface ArticleViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ArticleViewController

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

#pragma mark -
#pragma mark View lifecycle

// -------------------------------------------------------------------------------
//	viewDidLoad:
// -------------------------------------------------------------------------------
- (void)viewDidLoad
{
    // -setNavigationPaneBarButtonItem may have been invoked when before the
    // interface was loaded.  This will occur when setNavigationPaneBarButtonItem
    // is called as part of DetailViewManager preparing this view controller
    // for presentation as this is before the view is unarchived from the NIB.
    // When viewidLoad is invoked, the interface is loaded and hooked up.
    // Check if we are supposed to be displaying a navigationPaneBarButtonItem
    // and if so, add it to the toolbar.
    if (_navigationPaneBarButtonItem)
        self.navigationItem.leftBarButtonItem = self.navigationPaneBarButtonItem;
    
    self.title = self.articleTitle;
    self.webView.delegate = self;
    
    _mobilizer = @"";
    [self loadArticle];
}

-(void)mobilize
{
    _mobilizer = @"http://mobilizer.instapaper.com/m?u=";
    _webView.hidden = YES;
    [self loadArticle];
}


-(void)loadArticle{
    NSString *urlString = [NSString stringWithFormat:@"%@http://www.bechmann.co.uk/fg/GetJSData.aspx?id=%ld",_mobilizer, self.articleID];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                 NSASCIIStringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setFrame];
    
}

-(void)setFrame{
    
    float p =  self.view.frame.size.width / 768;
    p = p * 100;

    [_adView removeFromSuperview];
    _adView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, self.view.frame.size.height - (p-1), self.view.frame.size.width + 2, p)];
    _adView.image = [UIImage imageNamed:@"ad3.png"];
    _adView.layer.borderColor = [Tools colorFromHexString:@"#cccccc"].CGColor;
    _adView.layer.borderWidth = 1;
    [self.webView addSubview:_adView];
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - (p-1));
    
    _readingOptionsBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"736-zoom-in-toolbar.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(zoomIn)];
    UIBarButtonItem *zoomOutBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"737-zoom-out-toolbar.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(zoomIn)];
    UIBarButtonItem *favouriteBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"726-star-toolbar.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(setFrame)];
    UIBarButtonItem *mobilizeBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"810-document-2-toolbar.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(mobilize)];
    
    if (self.articleID > 0) {
        if([Tools isOrientationLandscape]){
            self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects: favouriteBtn, mobilizeBtn, nil];
            
            self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:_readingOptionsBtn, /*zoomOutBtn, */  nil];
        }
        else{
            self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:_readingOptionsBtn, /*zoomOutBtn,*/ favouriteBtn, mobilizeBtn,  nil];
            
        }
    }
}

-(void)zoomIn{

    ArticleOptionsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"articleReader"];
    UIPopoverController *popController = [[UIPopoverController alloc] initWithContentViewController:view];
    //?  popController.delegate = (id)self;
    _popover = popController;
    _popover.delegate = (id)self;
    [_popover presentPopoverFromBarButtonItem:_readingOptionsBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    
    //[self performSegueWithIdentifier:@"articleReadingOptions" sender:self];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setFrame];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %ld, %@", (long)webView.tag, error);
    [Tools hideLoaderFromView:self.view];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [Tools showLightLoaderWithView:self.view];
    //webView.hidden = YES;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Tools hideLoaderFromView:self.view];
    _webView.hidden = NO;
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(setFrame)
                                   userInfo:nil
                                    repeats:NO];
    
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
