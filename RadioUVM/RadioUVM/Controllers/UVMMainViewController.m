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

#import <MediaPlayer/MediaPlayer.h>

@interface UVMMainViewController ()

/*!
 * This property holds the audioController that plays
 * the radio stream. Needs to be a strong property
 * in order to keep playing the stream.
 * Because the Storyboard holds the reference
 * to the property.
 */
@property (strong, nonatomic)  FSAudioController * audioController;

/*!
 * This holds the volumePlaceholder that will become the MPVolumeView
 */
@property (weak, nonatomic) IBOutlet UIView *volumePlaceholder;

/*!
 * This property indicates if the streaming
 * is playing or paused;
 */
@property (nonatomic) BOOL paused;


/*!
 * This button changes its icon
 * depending on the streaming
 * state
 */
@property (weak, nonatomic) IBOutlet UIButton *playStopButton;


@end

@implementation UVMMainViewController

#pragma mark - Properties


- (FSAudioController *) audioController {

    // Lazy allocation method
    if (!_audioController) {
        _audioController = [[FSAudioController alloc] init];
    }
    
    return _audioController;
}


- (void) setPaused:(BOOL)paused {
    _paused = paused;
    
    // Set the image on pause state change.
    
    static UIImage * image;
    
    image = [UIImage imageNamed:@"286"];
    
    if (!paused) {
        image = [UIImage imageNamed:@"295"];
    }
    
    [self.playStopButton setImage:image forState:UIControlStateNormal];
}

#pragma mark - View Life Cycle

/*!
 * In View Did Load
 * we register to the Audio Streamer Notifications
 * And set the views
 */
- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Listen to State Change Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioStreamStateDidChange:)
                                                 name:FSAudioStreamStateChangeNotification
                                               object:nil];
    
    // Listen to Error Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioStreamErrorOccurred:)
                                                 name:FSAudioStreamErrorNotification
                                               object:nil];
    
    // Create the Volume View
    // See https://developer.apple.com/library/ios/documentation/mediaplayer/reference/MPVolumeView_Class/index.html
    
    self.volumePlaceholder.backgroundColor = [UIColor blackColor];
    
    self.volumePlaceholder.layer.cornerRadius = 10;
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: self.volumePlaceholder.bounds];
    
    
    volumeView.tintColor = [UIColor redColor];
    
    [self.volumePlaceholder addSubview:volumeView];
    
    // Listen to Remote Controls
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    // Set paused default state
    self.paused = YES;
    
    
    
}

/*
 * In View did Unload
 * we stop listening to
 * Audio Streamer Notifications
 */
- (void) viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
     [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

/*!
 * Just before view will appear
 * hide the navbar
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Hide NavBar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

/*!
 * Set the status bar as white colour
 */
- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Audio Streamer Delegate

/*!
 * This method is called when the streamer
 * is conecting or stopped.
 * We will show a Loading Screen.
 */

- (void) audioStreamStateDidChange: (NSNotification *) notification {
    
    NSLog(@"Audio State Change");
    
    NSDictionary *dict = [notification userInfo];
    
    int state = [[dict valueForKey:FSAudioStreamNotificationKey_State] intValue];
    
    // Show or dismiss the loading screen
    // depending on the state
    
    self.paused = YES;
    
    switch (state) {
            
        case kFsAudioStreamRetrievingURL:
        case kFsAudioStreamBuffering:
        case kFsAudioStreamSeeking:
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            
            [SVProgressHUD show];
            break;
            
        default:
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            break;
    }
    
    if (state == kFsAudioStreamPlaying) {
        self.paused = NO;
    }
    
}

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
    [UVMMessageHelper showStreamingErrorMessage];
    
    self.paused = YES;
}

#pragma mark - IBActions

- (IBAction)play:(id)sender {
    
    // Set the radio for the streamer
    if(!self.audioController.url) {
        
        UVMRadioModel * radio = [[UVMRadioModel allRadios] firstObject];
        
        self.audioController.url = radio.url;
    }
    
    
//     If we are paused, call pause again to unpause so
//     that the stream playback will continue.
    
    if (self.paused) {
        [self.audioController stop];
    }
    
    [self.audioController play];
    
}

- (IBAction)stop:(id)sender {
    
    [self.audioController stop];
    
    self.paused = YES;
}

- (IBAction)playStop:(id)sender {
    [self togglePlayStop];
}


#pragma mark - Remote Notifications

/*!
 * This method enables remote controlling
 * the streamer. For using the iOS native controls.
 */
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent
{
    NSLog(@"Remote Control Received");
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPause:
            case UIEventSubtypeRemoteControlPlay:
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self togglePlayStop];
                break;
            default:
                break;
        }
    }
}


#pragma mark - Private Methods
- (void) togglePlayStop {
    if (self.paused) {
        [self play:self];
    } else {
        [self stop:self];
    }
}
@end
