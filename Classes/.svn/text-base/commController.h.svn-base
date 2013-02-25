//
//  commController.h
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class audioController;

@interface commController : NSObject {
	audioController *_audioController;
	NSUInteger _baudRate;
	float _toneFrequency;
}

- (id)init;
- (void)sendByte:(NSUInteger)byte;
- (void)stopComLine;

@end
