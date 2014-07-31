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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
}
-(void)loadArticle{
    NSString *urlString = [NSString stringWithFormat:@"http://edition.pagesuite-professional.co.uk/launch.aspx?eid=2089178e-b89b-4a36-b360-ad8bb5e40f41"];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                 NSASCIIStringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
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
