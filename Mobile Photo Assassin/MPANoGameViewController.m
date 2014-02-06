//
//  MPANoGameViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/30/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPANoGameViewController.h"

@interface MPANoGameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation MPANoGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usernameLabel.text = self.currentUser.email;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
