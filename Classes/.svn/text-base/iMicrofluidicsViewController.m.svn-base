//
//  iMicrofluidicsViewController.m
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iMicrofluidicsViewController.h"
#import "channelDraw.h"
#import "commController.h"


@implementation iMicrofluidicsViewController

@synthesize positionLabel;
@synthesize slider;
@synthesize slideLeft;
@synthesize slideRight;
@synthesize channelView;

- (IBAction)changeValue:(id)sender{
	NSUInteger position = (NSUInteger) slider.value;
	
	_position=position;
	
	//unsigned char byte=(unsigned char) position;
	[comController sendByte:position];
		
	positionLabel.text = [NSString stringWithFormat:@"%d", position];
	[channelView setPosition:position];
}

- (IBAction)changeLeft:(id)sender{
	_position=_position-SLIDESTEP;
	
	if(_position<=5) {
		_position=5;
	}
	[comController sendByte:_position];
	
	slider.value=_position;
	
	positionLabel.text = [NSString stringWithFormat:@"%d", _position];
	[channelView setPosition:_position];
}

- (IBAction)changeRight:(id)sender{
	_position=_position+SLIDESTEP;
	
	if(_position>=250) {
		_position=250;
	}
	[comController sendByte:_position];
	
	slider.value=_position;
	
	positionLabel.text = [NSString stringWithFormat:@"%d", _position];
	[channelView setPosition:_position];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
 	[super viewDidLoad];
	comController = [[commController alloc] init];
	_position=(NSUInteger) slider.value;
	[self changeValue:nil];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
