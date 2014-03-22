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

@property (strong, nonatomic) MPAUser *currentUser;
@property (strong, nonatomic) MPAViewController *loginVC;
@property (strong, nonatomic) NSMutableArray* pendingGames;

- (UIViewController*) before:(UIViewController*)controller;
- (UIViewController*) after:(UIViewController*)controller;

- (IBAction)logoutTapped;

@end
