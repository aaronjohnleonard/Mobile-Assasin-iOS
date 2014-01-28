//
//  MPAHomeViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAHomeViewController.h"
#import "MPAViewController.h"
#import "MPATabViewController.h"

@interface MPAHomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *target;
@property (strong, nonatomic) MPAUser *currentUser;
@end

@implementation MPAHomeViewController

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
    MPATabViewController *tabBar = (MPATabViewController *)self.tabBarController;
    self.currentUser = tabBar.currentUser;
    
    self.usernameLabel.text = self.currentUser.email;
    self.target.text = self.currentUser.target.firstName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ShootTargetTapped {
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO))
        return;
    
    UIImagePickerController *camera = [[UIImagePickerController alloc]init];
    camera.sourceType = UIImagePickerControllerSourceTypeCamera;
    // camera.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    //camera.delegate = self;
    [self presentViewController: camera animated: YES completion:nil];
}

- (IBAction)LogoutTapped {
    MPAViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end















