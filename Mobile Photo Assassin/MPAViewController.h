//
//  MPAViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/16/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MPAUser.h"

@interface MPAViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) MPAUser *currentUser;

- (IBAction)unwindToWelcome:(UIStoryboardSegue *)segue;

@end
