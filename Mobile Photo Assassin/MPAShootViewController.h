//
//  MPAShootViewController.h
//  Mobile Photo Assassin
//
//  Created by Caleb Call on 2/4/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPASignUpViewController.h"

@interface MPAShootViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) MPASignUpViewController *signUpVC;

@end
