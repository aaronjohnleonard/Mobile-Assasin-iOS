//
//  MPAPageViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/8/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAUser.h"
#import "MPAViewController.h"

@interface MPAPageViewController : UIPageViewController

@property (weak, nonatomic) MPAUser *currentUser;
@property (strong, nonatomic) MPAViewController *loginVC;

- (UIViewController*) before:(UIViewController*)controller;
- (UIViewController*) after:(UIViewController*)controller;

- (IBAction)logoutTapped;

@end
