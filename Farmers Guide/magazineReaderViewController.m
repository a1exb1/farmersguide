//
//  magazineReaderViewController.m
//  Farmers Guide
//
//  Created by Alex Bechmann on 31/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "magazineReaderViewController.h"

@interface magazineReaderViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation magazineReaderViewController

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
    
    if (_navigationPaneBarButtonItem)
        self.navigationItem.leftBarButtonItem = self.navigationPaneBarButtonItem;
    
    self.webView.delegate = self;
    self.title = @"Farmers Guide Issue #337";
    [self loadArticle];
}
-(void)loadArticle{
    NSString *urlString = [NSString stringWithFormat:@"http://www.newforests.net/wp-content/uploads/2011/01/sample_pdf.pdf"];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                 NSASCIIStringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    self.webView.hidden = YES;
    [Tools showLightLoaderWithView:self.view];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.hidden = NO;
    [Tools hideLoaderFromView:self.view];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.webView.hidden = NO;
    [Tools hideLoaderFromView:self.view];
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
