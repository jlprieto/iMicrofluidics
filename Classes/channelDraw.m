//
//  channelDraw.m
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "channelDraw.h"


@implementation channelDraw


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
	CGContextAddRect(context, CGRectMake(0.0, 0.0, _position, self.bounds.size.height));
	CGContextFillPath(context);
	
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.0f green:0.5f blue:0.0f alpha:1.0f].CGColor);
	CGContextAddRect(context, CGRectMake(_position, 0.0, self.bounds.size.width-_position, self.bounds.size.height));
	CGContextFillPath(context);
	
}

- (void) setPosition:(NSUInteger)position {
	_position=position;
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}


@end
