//
//  iMicrofluidicsAppDelegate.h
//  iMicrofluidics
//
//  Created by xavi on 3/18/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iMicrofluidicsViewController;

@interface iMicrofluidicsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iMicrofluidicsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iMicrofluidicsViewController *viewController;

@end

