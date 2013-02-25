//
//  iMicrofluidicsAppDelegate.m
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iMicrofluidicsAppDelegate.h"
#import "iMicrofluidicsViewController.h"

@implementation iMicrofluidicsAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch  
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
