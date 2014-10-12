//
//  UVMAboutViewController.m
//  RadioUVM
//
//  Created by Camilo Castro on 12-10-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import "UVMAboutViewController.h"

@interface UVMAboutViewController ()

@end

@implementation UVMAboutViewController

/*!
 * Just before view will appear
 * show the navbar
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Hide NavBar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
