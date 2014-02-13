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
#import "MPAPageViewController.h"
#import "MPANoGameViewController.h"

@interface MPAViewController()
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;

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
        
    }
    else if([segue.identifier isEqualToString:@"noGame"]){
        self.currentUser.email = self.email.text;
        MPANoGameViewController *noGameVC = segue.destinationViewController;
        noGameVC.currentUser = self.currentUser;
    }
}

- (IBAction)unwindToWelcome:(UIStoryboardSegue *)segue
{
    self.email.text = self.currentUser.email;
    self.password.text = self.currentUser.password;
    [self.email becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentUser = [[MPAUser alloc]init];
    self.email.delegate = (id)self;
    self.password.delegate = (id)self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginTapped {
    // Verify user has actually inputted information
    if([self.email.text  isEqualToString: @""] || [self.password.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please enter your information"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    // Query server using inputted credentials
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://leonard.tk/app/mobileAssassin/%@/%@",self.email.text,self.password.text]]
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:30];
    // Fetch the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:nil];
    
    // Get the user information
    json = [json valueForKey:@"user"];
    
    // If the json doesn't have user information, send alert to user
    if (json == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Invalid credentials"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // Create new user using json from server
    MPAUser *currentUser = [[MPAUser alloc] initWithFirstName:[json valueForKey:@"firstName"]
                                                     lastName:[json valueForKey:@"lastName"]
                                                        email:[json valueForKey:@"email"]
                                                     password:[json valueForKey:@"password"]
                                                       target:[[MPAUser alloc] initWithName:@"Bill"]];
    
    // If the user is in a game, go to main tab scene, otherwise go to noGame scene
    if ([[json valueForKey:@"game"] isEqualToString:@"true"]) {
        MPAPageViewController *pageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pageVC"];
        //homeVC.currentUser = currentUser;
        [self presentViewController:pageVC animated:YES completion:nil];
    }
    else{
        [self performSegueWithIdentifier:@"noGame"
                                  sender:self];
    }
    
}

- (IBAction)SignUpTapped:(UIButton *)sender {
    MPASignUpViewController *signUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    signUpVC.delegate = self;
    signUpVC.upcomingUser = self.currentUser;
    [self presentViewController:signUpVC animated:YES completion:nil];
}


@end


