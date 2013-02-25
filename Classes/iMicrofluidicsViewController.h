//
//  iMicrofluidicsViewController.h
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class channelDraw;
@class commController;

#define SLIDESTEP 5;

@interface iMicrofluidicsViewController : UIViewController {
	IBOutlet UISlider *slider; //Slider to Control Fluid interface
	IBOutlet UILabel *positionLabel; //Label that will show the position that we are transmitting to the Arduino
	IBOutlet UIButton *slideLeft; //Button to move fluid interface left
	IBOutlet UIButton *slideRight; //Button to move fluid interface right
	IBOutlet channelDraw *channelView; //UIView that draws the fluid interface
	commController *comController; //Communications Controller
	NSUInteger _position;
}

@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UILabel *positionLabel;
@property (nonatomic, retain) UIButton *slideLeft;
@property (nonatomic, retain) UIButton *slideRight;
@property (nonatomic, retain) channelDraw *channelView;

- (IBAction)changeValue:(id)sender;
- (IBAction)changeLeft:(id)sender;
- (IBAction)changeRight:(id)sender;

@end

