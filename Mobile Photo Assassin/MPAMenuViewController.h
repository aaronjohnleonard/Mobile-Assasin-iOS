//
//  MPAMenuViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/8/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAUser.h"
#import "MPAPageViewController.h"

@interface MPAMenuViewController : UIViewController

@property (strong, nonatomic) MPAUser *user;
@property (strong, nonatomic) MPAPageViewController *parent;

@end
