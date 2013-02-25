//
//  commController.m
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "commController.h"
#import "audioController.h"

@implementation commController

-(id)init{
	if(self = [super init]) {
		// Start Communications Line
		_baudRate=2;
		_toneFrequency=17000;
		_audioController = [[audioController alloc] init];
		[_audioController init];
		[_audioController start];
	}	
	return self;
}


- (void)sendByte:(NSUInteger)byte{
	[_audioController encodeByte:byte];
}

- (void)stopComLine{
//	[_audioController stopAudio];
}

@end
