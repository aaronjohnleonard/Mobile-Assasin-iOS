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
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *target;
@property (strong, nonatomic) MPAUser *currentUser;
@end

@implementation MPAHomeViewController

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if([identifier isEqualToString:@"quit"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Are you sure?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
        [alert show];
    }
    
    return NO;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// 1 = Tapped yes
	if (buttonIndex == 1)
	{
		[self performSegueWithIdentifier:@"quit" sender:self];
	}
}

- (IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

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
    [self performSegueWithIdentifier:@"logout" sender:self];
    /*MPAViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"logout"];
    [self presentViewController:loginVC
                       animated:YES
                     completion:nil];
     */
}

@end















