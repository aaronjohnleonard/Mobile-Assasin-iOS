    //
//  MPAHomeViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAHomeViewController.h"
#import "MPAViewController.h"
#import "MPAPageViewController.h"
#import "MPAShootTargetViewController.h"

@interface MPAHomeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *target;
@property (strong, nonatomic) IBOutlet UIImageView *targetImage;
@end

@implementation MPAHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.usernameLabel.text = self.username;
    self.target.text = ((MPAUser*)self.user.targets[self.targetIndex]).firstName;
    
    [self.targetImage setImage:((MPAUser*)self.user.targets[self.targetIndex]).photo];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shootTarget {
    MPAShootTargetViewController *shootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShootTargetVC"];
    shootVC.gameId = self.gameId;
    [self presentViewController:shootVC animated:YES completion:nil];
}

- (IBAction)logoutTapped:(id)sender {
    [self.pageVC logoutTapped];
}


@end















