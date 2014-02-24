//
//  MPASignUpViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAUser.h"

@interface MPASignUpViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) MPAUser *user;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
