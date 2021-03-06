//
//  MPAShootTargetViewController.h
//  Mobile Photo Assassin
//
//  Created by Caleb Call on 3/2/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPATargetViewController.h"

@interface MPAShootTargetViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *gameId;
@property (strong, nonatomic) MPATargetViewController *targetVC;

@end
