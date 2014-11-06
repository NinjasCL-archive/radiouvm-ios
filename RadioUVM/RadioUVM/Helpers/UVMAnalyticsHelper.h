//
//  UVMAnalyticsHelper.h
//  RadioUVM
//
//  Created by Camilo Castro on 05-11-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * Tells what ID key must be used
 * to interact with Google Analytics
 */
extern NSString *  const kUVMAnalyticsKey;

/*!
 * This class have methods for tracking
 * events in Google Analytics
 */
@interface UVMAnalyticsHelper : NSObject

#pragma mark - Buttons

/*!
 * Tracks if the user touched
 * the big play button
 */
+ (void) trackBigPlayButton;

/*!
 * Tracks if the user touched
 * the small play button
 */
+ (void) trackSmallPlayButton;

/*!
 * Tracks if the player was controller
 * using remote controls
 */
+ (void) trackRemoteControls;

#pragma mark - Streamer

/*!
 * Track if the streaming started
 * playing
 */
+ (void) trackStartPlaying;

/*!
 * Track if the streaming stopped
 * playing
 */
+ (void) trackStopPlaying;

/*!
 * Track if the streaming had an error
 * playing
 */
+ (void) trackSteamerError;

/*!
 * Track when the time interval
 * since the streaming started and the streamer
 * stoped
 */
+ (void) trackTotalListeningTimeSinceDate:(NSDate *) startAt;

@end
