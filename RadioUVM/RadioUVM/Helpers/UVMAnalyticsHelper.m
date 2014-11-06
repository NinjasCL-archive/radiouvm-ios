//
//  UVMAnalyticsHelper.m
//  RadioUVM
//
//  Created by Camilo Castro on 05-11-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import "UVMAnalyticsHelper.h"
#import <GoogleAnalytics-iOS-SDK/GAI.h>
#import <GoogleAnalytics-iOS-SDK/GAIDictionaryBuilder.h>

/*!
 * Tells what ID key must be used
 * to interact with Google Analytics
 */
NSString * const kUVMAnalyticsKey = @"UA-56460925-1";

// Tracker Variable
static id <GAITracker> _tracker;

// Constants

// Categories
NSString * const kUVMUIActionCategory = @"UI Action";

NSString * const kUVMStreamerStateCategory = @"Streamer State";

NSString * const kUVMListeningTimeCategory = @"Listening Time";


// Actions
NSString * const kUVMButtonPressAction = @"Button Press";

NSString * const kUVMStreamerStateChangedAction = @"Streamer State Changed";

// Names
NSString * const kUVMListeningTimeName = @"Listening Time";

@interface UVMAnalyticsHelper()

@end

@implementation UVMAnalyticsHelper

/*!
 * Tracks if the user touched
 * the big play button
 */
+ (void) trackBigPlayButton {
    [self trackEventWithCategory:kUVMUIActionCategory action:kUVMButtonPressAction label:@"Big Play Button" value:nil];
}

/*!
 * Tracks if the user touched
 * the small play button
 */
+ (void) trackSmallPlayButton {
    [self trackEventWithCategory:kUVMUIActionCategory action:kUVMButtonPressAction label:@"Small Play Button" value:nil];
}

/*!
 * Tracks if the player was controller
 * using remote controls
 */
+ (void) trackRemoteControls {
    [self trackEventWithCategory:kUVMUIActionCategory action:kUVMButtonPressAction label:@"Remote Controls Used" value:nil];
}

#pragma mark - Streamer
/*!
 * Track if the streaming started
 * playing
 */
+ (void) trackStartPlaying {
    [self trackEventWithCategory:kUVMStreamerStateCategory action:kUVMStreamerStateChangedAction label:@"Started Streamer" value:nil];
}

/*!
 * Track if the streaming stopped
 * playing
 */
+ (void) trackStopPlaying {
    [self trackEventWithCategory:kUVMStreamerStateCategory action:kUVMStreamerStateChangedAction label:@"Stopped Streamer" value:nil];
}

/*!
 * Track if the streaming had an error
 * playing
 */
+ (void) trackSteamerError {
    [self trackEventWithCategory:kUVMStreamerStateCategory action:kUVMStreamerStateChangedAction label:@"Streaming Error" value:nil];
}

/*!
 * Track when the time interval
 * since the streaming started and the streamer
 * stoped
 */
+ (void) trackTotalListeningTimeSinceDate:(NSDate *) startAt {
    
    double since = [[NSDate date] timeIntervalSinceDate:startAt];
    
    [self trackTimingWithCategory:kUVMListeningTimeCategory interval:@(since) name:kUVMListeningTimeName label:@"Listening Time"];
    
}

#pragma mark - Utility

+ (void) trackEventWithCategory: (NSString * ) category action: (NSString *) action label: (NSString *) label value: (NSNumber *) value {
    
    NSDictionary * event = [[GAIDictionaryBuilder createEventWithCategory:category  action:action label:label value:value] build];
    
    [[self tracker] send:event];
    
}

+ (void) trackTimingWithCategory : (NSString *) category  interval:(NSNumber *) interval name:(NSString *) name label : (NSString *) label {
    
    NSDictionary * event = [[GAIDictionaryBuilder createTimingWithCategory:category interval:interval name:name label:label] build];
    
    [[self tracker] send:event];
}




+ (id<GAITracker>) tracker {
    
    if (!_tracker) {
        _tracker = [[GAI sharedInstance] defaultTracker];
    }
    
    return _tracker;
}

@end
