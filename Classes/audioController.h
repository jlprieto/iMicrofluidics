//
//  audioController.h
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioUnit/AudioUnit.h>

@interface audioController : NSObject {
	AudioUnit audioUnit;
	void* buffer;
	BOOL sendByte;
	unsigned int byte;
}

@property BOOL sendByte;
@property unsigned int byte;
@property void* buffer;

-(id)init;
-(void)encodeByte:(NSUInteger) value;
-(void)start;
-(void)stopAudio;

@end
