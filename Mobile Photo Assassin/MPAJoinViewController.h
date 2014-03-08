//
//  MPAJoinViewController.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/25/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAUser.h"

@interface MPAJoinViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) MPAUser *currentUser;

@end
