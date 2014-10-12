//
//  UVMMessageHelper.m
//  RadioUVM
//
//  Created by Camilo Castro on 12-10-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import "UVMMessageHelper.h"

@implementation UVMMessageHelper

#pragma mark - Abstract Methods

/*!
 * Shows an UIAlertView that tells the
 * user that we can no longer reproduce
 * the stream.
 */
+ (void) showStreamingErrorMessage {

    NSString * message = NSLocalizedString(@"No se ha logrado conectar al servidor.", @"Show when the internet is down or server error");
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
}


@end
