//
//  MPAShootViewController.h
//  Mobile Photo Assassin
//
//  Created by Caleb Call on 2/4/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPAShootViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    IBOutlet UIImageView *imageView;
}

- (IBAction)TakePhoto;
- (IBAction)ChooseExisting;


@end
