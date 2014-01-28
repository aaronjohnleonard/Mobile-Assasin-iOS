//
//  MPAViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/16/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAViewController.h"
#import "MPAHomeViewController.h"
#import "MPASignUpViewController.h"
#import "MPATabViewController.h"

@interface MPAViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation MPAViewController

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if ([identifier isEqualToString:@"logIn"]) {
        if([self.email.text  isEqualToString: @""] || [self.password.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Please enter your information"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"logIn"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"You are now logged in"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        self.currentUser.target = [[MPAUser alloc] initWithName:@"Max"];
        self.currentUser.email = self.email.text;
        
        MPATabViewController *tabVC = segue.destinationViewController;
        tabVC.currentUser = self.currentUser;
    }
    else if([segue.identifier isEqualToString:@"signUp"]){
        
    }
}

- (IBAction)unwindToWelcome:(UIStoryboardSegue *)segue
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"You are now signed up!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    self.email.text = self.currentUser.email;
    self.password.text = self.currentUser.password;
    [self.email becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentUser = [[MPAUser alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginTapped {
    if([self.email.text  isEqualToString: @""] || [self.password.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please enter your information"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    UITabBarController *tabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabVC"];
    MPAHomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];

    homeVC.user = self.currentUser;
    [self presentViewController:tabVC
                       animated:YES
                     completion:nil];
}

- (IBAction)SignUpTapped:(UIButton *)sender {
    MPASignUpViewController *signUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    signUpVC.delegate = self;
    signUpVC.upcomingUser = self.currentUser;
    [self presentViewController:signUpVC animated:YES completion:nil];
}

@end


