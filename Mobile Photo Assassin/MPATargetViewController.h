//
//  MPAHomeViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAUser.h"
#import "MPAPageViewController.h"

@interface MPATargetViewController : UIViewController
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) MPAUser *user;
@property (strong, nonatomic) NSString *gameId;
@property (strong, nonatomic) MPAPageViewController *pageVC;
@property (nonatomic) NSInteger targetIndex;
@end
