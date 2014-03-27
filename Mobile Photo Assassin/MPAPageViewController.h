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
//#import "MPAHomeViewController.h"

@interface MPAPageViewController : UIPageViewController

@property (strong, nonatomic) MPAUser *currentUser;
@property (strong, nonatomic) MPAViewController *loginVC;

- (UIViewController*) before:(UIViewController*)controller;
- (UIViewController*) after:(UIViewController*)controller;
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController;
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController;

- (NSInteger)numPages;
- (NSInteger)currentPageForViewController:targetVC;

- (IBAction)logoutTapped;

@end
