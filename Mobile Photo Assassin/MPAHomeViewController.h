//
//  MPAHomeViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAUser.h"

@interface MPAHomeViewController : UIViewController
@property (weak, nonatomic) NSString *username;
@property (strong, nonatomic) MPAUser *user;
@end
