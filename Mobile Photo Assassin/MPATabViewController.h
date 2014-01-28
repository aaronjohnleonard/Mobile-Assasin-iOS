//
//  MPATabViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/19/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAUser.h"

@interface MPATabViewController : UITabBarController

@property (strong, nonatomic) MPAUser *currentUser;

@end
