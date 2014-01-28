//
//  MPASignUpViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAViewController.h"

@protocol MPASignUpViewControllerDelegate;

@interface MPASignUpViewController : UIViewController

@property (strong, nonatomic) MPAViewController *delegate;
@property (strong, nonatomic) MPAUser *upcomingUser;

@end
