//
//  UVMMainViewController.m
//  RadioUVM
//
//  Created by Camilo Castro on 12-10-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import "UVMMainViewController.h"

#import <FreeStreamer/FSAudioController.h>
#import <FreeStreamer/FSAudioStream.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "UVMRadioModel.h"
#import "UVMMessageHelper.h"

@interface UVMMainViewController ()

/*!
 * This property holds the audioController that plays
 * the radio stream. Needs to be a weak property
 * in order to keep playing the stream.
 * Because the Storyboard holds the reference
 * to the property.
 */
@property (weak, nonatomic) IBOutlet FSAudioController * audioController;

@end

@implementation UVMMainViewController

#pragma mark - View Life Cycle

/*!
 * In View Did Load
 * we register to the Audio Streamer Notifications
 */
- (void) viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioStreamStateDidChange:)
                                                 name:FSAudioStreamStateChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioStreamErrorOccurred:)
                                                 name:FSAudioStreamErrorNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioStreamMetaDataAvailable:)
                                                 name:FSAudioStreamMetaDataNotification
                                               object:nil];
}

/*
 * In View did Unload
 * we stop listening to
 * Audio Streamer Notifications
 */
- (void) viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Audio Streamer Delegate

/*!
 * This method is called when
 * the streamer could not continue
 */
- (void) audioStreamErrorOccurred: (NSNotification *) notification {
    
    // Extract the Error
    
    NSLog(@"Audio Error");
    
    NSDictionary *dict = [notification userInfo];
    
    int errorCode = [[dict valueForKey:FSAudioStreamNotificationKey_Error] intValue];
    
    
    switch (errorCode) {
        case kFsAudioStreamErrorOpen:
            NSLog( @"Cannot open the audio stream");//////////////////////////////////////
            break;
        case kFsAudioStreamErrorStreamParse:
            NSLog(@"Cannot read the audio stream");
            break;
        case kFsAudioStreamErrorNetwork:
            NSLog(@"Network failed: cannot play the audio stream");
            break;
        default:
            NSLog(@"Unknown error occurred");
            break;
    }
    
    // Show a Message to the User
    
}

@end
