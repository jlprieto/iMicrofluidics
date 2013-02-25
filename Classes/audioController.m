//
//  audioController.m
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AudioUnit/AudioUnit.h>
#import <math.h>

#import "audioController.h"

#define kOutputBus 0
#define kSampleRate 44100
#define kWaveform (M_PI * 2.0f / kSampleRate)
#define toneFrequency 9000.0f
#define baudRate 244
#define byteLength 9
#define bytesInBuffer 10

@implementation audioController

@synthesize byte;
@synthesize sendByte;
@synthesize buffer;

static OSStatus playbackCallback(void *inRefCon,
						  AudioUnitRenderActionFlags *ioActionFlags,
						  const AudioTimeStamp *inTimeStamp,
						  UInt32 inBusNumber, 
						  UInt32 inNumberFrames,
						  AudioBufferList *ioData) {	
	
	static int phase = 0;
	audioController* audioC=(audioController*) inRefCon;
	
	ioData->mNumberBuffers=1;
	ioData->mBuffers[0].mData=audioC.buffer;
	char localByte=audioC.byte;
	BOOL localsendByte = audioC.sendByte;
	
	int samples = byteLength*bytesInBuffer*kSampleRate/baudRate;
	ioData->mBuffers[0].mDataByteSize=sizeof(SInt16)*samples;
	ioData->mBuffers[0].mNumberChannels=1;
	 
	SInt16 values[samples];
	float waves;
	unsigned int bit;	
	
	if(localsendByte)
	{
		for(int k=0; k<(byteLength*bytesInBuffer); k++){
			if(k==0 || k==9){
				bit=0;
			}else if(k>0 && k<9){
				bit=localByte & 0x80;
				localByte=localByte<<1;
			}else{
				bit=1;
			}
			for(int j = k*samples/(byteLength*bytesInBuffer) ; j < (k+1)*samples/(bytesInBuffer*byteLength); j++) {
				waves = 0;			
				waves += sin(kWaveform * toneFrequency * phase);			 
				waves *= 32500 / 1; // <--------- make sure to divide by how many waves you're stacking
				if(bit){
					values[j] = (SInt16)waves;
				}else{
					values[j] = 30000;
				}
				values[j] += values[j]<<16;
				phase++;
			}
		}
		audioC.sendByte=NO;
	}else {		
		for(int j = 0; j < samples; j++) {
			waves = 0;			
			waves += sin(kWaveform * toneFrequency * phase);			 
			//waves *= 15000 / 1; // <--------- make sure to divide by how many waves you're stacking
			waves *= 32500 / 1; // <--------- make sure to divide by how many waves you're stacking
			//if(j>samples/(bytesInBuffer*byteLength))
				values[j] = (SInt16)waves;
			//else
			//	values[j] = 0;
			
			values[j] += values[j]<<16;
			phase++;
		}
	}
	
	memcpy(ioData->mBuffers[0].mData, values, samples * sizeof(SInt16));
	return noErr;
}





-(id)init{
	if(self = [super init]) {
		OSStatus status;
		
		byte=0;
		sendByte=NO;
		buffer=malloc(sizeof(SInt16)*bytesInBuffer*byteLength*kSampleRate/baudRate);
		
		//Initialize audio unit
		AudioComponentDescription desc;
		desc.componentType = kAudioUnitType_Output;
		desc.componentSubType = kAudioUnitSubType_RemoteIO;
		desc.componentFlags = 0;
		desc.componentFlagsMask = 0;
		desc.componentManufacturer = kAudioUnitManufacturer_Apple;
		
		AudioComponent outputComponent = AudioComponentFindNext(NULL, &desc);
		
		status = AudioComponentInstanceNew(outputComponent, &audioUnit);
		
		UInt32 flag = 1;
		status = AudioUnitSetProperty(audioUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, kOutputBus, &flag, sizeof(flag));
		
		AudioStreamBasicDescription audioFormat;
		audioFormat.mSampleRate = kSampleRate;
		audioFormat.mFormatID = kAudioFormatLinearPCM;
		audioFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
		audioFormat.mFramesPerPacket = 1;
		audioFormat.mChannelsPerFrame = 1;
		audioFormat.mBitsPerChannel = 16;
		audioFormat.mBytesPerPacket = 2;
		audioFormat.mBytesPerFrame = 2;
		
		status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, kOutputBus, &audioFormat, sizeof(audioFormat));
		
		AURenderCallbackStruct callbackStruct;
		callbackStruct.inputProc = playbackCallback;
		callbackStruct.inputProcRefCon = self;
		
		// Disable buffer allocation (optional - do this if we want to pass in our own)
		flag = 1;
		status = AudioUnitSetProperty(audioUnit, 
									  kAudioUnitProperty_ShouldAllocateBuffer,
									  kAudioUnitScope_Output, 
									  kOutputBus,
									  &flag, 
									  sizeof(flag));
		
		status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_SetRenderCallback, kAudioUnitScope_Global, kOutputBus, &callbackStruct, sizeof(callbackStruct));
		
		status = AudioUnitInitialize(audioUnit);
		 
	}	
	return self;
}



-(void)start{
	OSStatus status;
	status = AudioOutputUnitStart(audioUnit);	
}


-(void)encodeByte:(NSUInteger) value
{
	byte = (unsigned int)value;
	if(sendByte==NO) sendByte=YES;
	else sendByte=NO;
}


-(void)stopAudio{
	OSStatus status;
	status = AudioOutputUnitStop(audioUnit);	
}

-(void)dealloc {
	AudioUnitUninitialize(audioUnit);
	[super dealloc];
}

@end
