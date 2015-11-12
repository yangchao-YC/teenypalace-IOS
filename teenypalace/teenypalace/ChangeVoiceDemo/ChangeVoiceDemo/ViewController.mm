//
//  ViewController.m
//  ChangeVoiceDemo
//
//  Created by 李 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioServices.h>
#include "Dirac.h"
#include <stdio.h>
#include <sys/time.h>
#import "EAFRead.h"
#import "EAFWrite.h"

double gExecTimeTotal = 0.;
void DeallocateAudioBuffer(float **audio, int numChannels)
{
	if (!audio) return;
	for (long v = 0; v < numChannels; v++) {
		if (audio[v]) {
			free(audio[v]);
			audio[v] = NULL;
		}
	}
	free(audio);
	audio = NULL;
}

float **AllocateAudioBuffer(int numChannels, int numFrames)
{
	// Allocate buffer for output
	float **audio = (float**)malloc(numChannels*sizeof(float*));
	if (!audio) return NULL;
	memset(audio, 0, numChannels*sizeof(float*));
	for (long v = 0; v < numChannels; v++) {
		audio[v] = (float*)malloc(numFrames*sizeof(float));
		if (!audio[v]) {
			DeallocateAudioBuffer(audio, numChannels);
			return NULL;
		}
		else memset(audio[v], 0, numFrames*sizeof(float));
	}
	return audio;
}	


long myReadData(float **chdata, long numFrames, void *userData)
{	
	if (!chdata)	return 0;
	
	ViewController *Self = (ViewController*)userData;
	if (!Self)	return 0;
	
	gExecTimeTotal += DiracClockTimeSeconds(); 		
    
	OSStatus err = [Self.reader readFloatsConsecutive:numFrames intoArray:chdata];
	
	DiracStartClock();								
	return err;
	
}
@interface ViewController ()

@end

@implementation ViewController
@synthesize reader;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *inputSound  = [[[NSHomeDirectory() stringByAppendingString:@"/Documents/"] stringByAppendingString:@"audio.wav"] retain];
	NSString *outputSound = [[[NSHomeDirectory() stringByAppendingString:@"/Documents/"] stringByAppendingString:@"out.aif"] retain];
	inUrl = [[NSURL fileURLWithPath:inputSound] retain];
	outUrl = [[NSURL fileURLWithPath:outputSound] retain];
	reader = [[EAFRead alloc] init];
	writer = [[EAFWrite alloc] init];
    [progress setProgress:0];
}
-(IBAction)Start:(id)sender
{
    [NSThread detachNewThreadSelector:@selector(processThread:) toTarget:self withObject:nil];
}
-(void)processThread:(id)param
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	long numChannels = 1;		// DIRAC LE allows mono only
	float sampleRate = 44100.;
    
    reader = [[EAFRead alloc] init];
	writer = [[EAFWrite alloc] init];
    
	[reader openFileForRead:inUrl sr:sampleRate channels:numChannels];
	
	[writer openFileForWrite:outUrl sr:sampleRate channels:numChannels wordLength:16 type:kAudioFileAIFFType];	
	
	float time      = speed.value;                
	float pitch     = soundPitch.value;
	float formant   = volume.value; 
	
    void *dirac = DiracCreate(kDiracLambdaPreview, kDiracQualityPreview, numChannels, sampleRate, &myReadData, (void*)self);
	
	if (!dirac) {
		printf("!! ERROR !!\n\n\tCould not create DIRAC instance\n\tCheck number of channels and sample rate!\n");
		printf("\n\tNote that the free DIRAC LE library supports only\n\tone channel per instance\n\n\n");
		exit(-1);
	}
	
	DiracSetProperty(kDiracPropertyTimeFactor, time, dirac);
	DiracSetProperty(kDiracPropertyPitchFactor, pitch, dirac);
	DiracSetProperty(kDiracPropertyFormantFactor, formant, dirac);
    
	if (pitch > 1.0)
		DiracSetProperty(kDiracPropertyUseConstantCpuPitchShift, 1, dirac);
    
	DiracPrintSettings(dirac);
	
	NSLog(@"Running DIRAC version %s\nStarting processing", DiracVersion());
	
	SInt64 numf = [reader fileNumFrames];
	SInt64 outframes = 0;
	SInt64 newOutframe = numf*time;
	long lastPercent = -1;
	percent = 0;
	
	long numFrames = 8192;
	
	float **audio = AllocateAudioBuffer(numChannels, numFrames);
    
	double bavg = 0;
	
	for(;;) {
		
		percent = 100.f*(double)outframes / (double)newOutframe;
		long ipercent = percent;
        
		if (lastPercent != percent) 
        {
			[self performSelectorOnMainThread:@selector(updateBarOnMainThread:) withObject:self waitUntilDone:NO];
			printf("\rProgress: %3i%% [%-40s] ", ipercent, &"||||||||||||||||||||||||||||||||||||||||"[40 - ((ipercent>100)?40:(2*ipercent/5))] );
			lastPercent = ipercent;
			fflush(stdout);
		}
		
		DiracStartClock();								
		long ret = DiracProcess(audio, numFrames, dirac);
		bavg += (numFrames/sampleRate);
		gExecTimeTotal += DiracClockTimeSeconds();				
		printf("x realtime = %3.3f : 1 (DSP only), CPU load (peak, DSP+disk): %3.2f%%\n", bavg/gExecTimeTotal, DiracPeakCpuUsagePercent(dirac));
		
		long framesToWrite = numFrames;
		unsigned long nextWrite = outframes + numFrames;
		if (nextWrite > newOutframe) framesToWrite = numFrames - nextWrite + newOutframe;
		if (framesToWrite < 0) framesToWrite = 0;
		
		[writer writeFloats:framesToWrite fromArray:audio];
		outframes += numFrames;
		
		if (ret <= 0)
            break;
	}
	
	percent = 100;
	[self performSelectorOnMainThread:@selector(updateBarOnMainThread:) withObject:self waitUntilDone:NO];
    
	DeallocateAudioBuffer(audio, numChannels);
	DiracDestroy( dirac );
	
	// Done!
	NSLog(@"\nDone!");
	
	[reader release];
	[writer release]; 
    reader = nil;
    writer = nil;
	
	[self playOnMainThread];
	
	[pool release];
}
-(void)updateBarOnMainThread:(id)sender
{
    //NSLog(@"%f",percent);
    [progress setProgress:percent];
}
-(IBAction)ValueChanged:(id)sender
{
    [speedValue setText:[NSString stringWithFormat:@"%f",speed.value]];
    [pitchValue setText:[NSString stringWithFormat:@"%f",soundPitch.value]];
    [volumeValue setText:[NSString stringWithFormat:@"%f",volume.value]];
}
-(void)playOnMainThread
{
	NSError *error = nil;
    if(player!=nil)
    {
        [player release];
        player = nil;
    }
	player = [[AVAudioPlayer alloc] initWithContentsOfURL:outUrl error:&error];
	if (error)
		NSLog(@"AVAudioPlayer error %@, %@", error, [error userInfo]);
    
	//player.delegate = self;
    percent = 0;
	[player play];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
