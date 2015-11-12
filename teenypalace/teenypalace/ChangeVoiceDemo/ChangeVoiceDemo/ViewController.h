//
//  ViewController.h
//  ChangeVoiceDemo
//
//  Created by 李 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import "EAFRead.h"
#import "EAFWrite.h"


@interface ViewController : UIViewController
{
    IBOutlet UISlider *speed;
    IBOutlet UISlider *soundPitch;
    IBOutlet UISlider *volume;
    
    EAFRead *reader;
    EAFWrite *writer;
    float percent;
    NSURL *inUrl;
	NSURL *outUrl;
    AVAudioPlayer *player;
    
    IBOutlet UILabel *speedValue;
    IBOutlet UILabel *pitchValue;
    IBOutlet UILabel *volumeValue;
    IBOutlet UIProgressView *progress;
}
@property (retain) EAFRead *reader;
@end
