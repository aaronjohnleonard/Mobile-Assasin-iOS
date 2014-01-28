//
//  MPASetBombViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/18/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPASetBombViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *location;

@end
