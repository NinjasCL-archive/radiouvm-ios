//
//  UVMMessageHelper.h
//  RadioUVM
//
//  Created by Camilo Castro on 12-10-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * This class holds messages for the user
 * that are shown within the app.
 */
@interface UVMMessageHelper : NSObject

#pragma mark - Abstract Methods

/*!
 * Shows an UIAlertView that tells the
 * user that we can no longer reproduce
 * the stream.
 */
+ (void) showStreamingErrorMessage;

@end
