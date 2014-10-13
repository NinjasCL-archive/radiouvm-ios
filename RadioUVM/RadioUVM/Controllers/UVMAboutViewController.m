//
//  UVMAboutViewController.m
//  RadioUVM
//
//  Created by Camilo Castro on 12-10-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import "UVMAboutViewController.h"

@interface UVMAboutViewController () <UIWebViewDelegate>

/*!
 * The Web Browser for Showing the Info
 */
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation UVMAboutViewController

#pragma mark - View Life Cycle

/*!
 * Set the delegate for the webview
 */
- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
}

/*!
 * Just before view will appear
 * show the navbar
 */
- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Hide NavBar
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.webView.hidden = YES;
}

/*!
 * Load the about webpage
 */
- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    // Load Web
    // in background thread
    // for not blocking
    // main UI
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"about" withExtension:@"html"];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:2629743]];
    });
}

/*!
 * Show the WebView when Finished loading about page
 */
- (void) webViewDidFinishLoad:(UIWebView *)webView {
    self.webView.hidden = NO;
}



@end
