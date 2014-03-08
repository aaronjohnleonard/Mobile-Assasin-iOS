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
        
        
    }
    else if([segue.identifier isEqualToString:@"noGame"]){
        self.currentUser.username = self.email.text;
        MPANoGameViewController *noGameVC = segue.destinationViewController;
        noGameVC.currentUser = self.currentUser;
    }
}

- (IBAction)unwindToWelcome:(UIStoryboardSegue *)segue
{
    self.email.text = self.currentUser.username;
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

    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@", self.email.text, self.password.text];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://54.200.120.14:8080/member/authenticate"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    request.HTTPBody = postData;
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response
                                                error:&error];
    
    NSMutableURLRequest *inforequest = [[NSMutableURLRequest alloc] init];
    [inforequest setURL:[NSURL URLWithString:@"http://54.200.120.14:8080/startAppInfo"]];
    [inforequest setHTTPMethod:@"GET"];
    
    urlData = [NSURLConnection sendSynchronousRequest:inforequest
                                    returningResponse:&response
                                                error:&error];
    
    // NSLog(@"%@", [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]);
    
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:nil];
    
    
    // If the json doesn't have user information, send alert to user
    if (info == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Invalid credentials"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSArray *targetsData = [info valueForKey:@"targets"];
    
    NSMutableArray *targetObjects = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [targetsData count]; i++) {
        NSDictionary *targetData = targetsData[i];
        NSString *targetName = [[targetData valueForKey:@"target"] valueForKey:@"firstName"];
        id targetID = [[targetData valueForKey:@"target"] valueForKey:@"memberId"];
        
        NSURL *imageurl = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.200.120.14:8080/member/photo/%@",targetID]];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageurl];
        UIImage *targetPhoto = [UIImage imageWithData:imageData];
        MPAUser *target = [[MPAUser alloc] initWithName:targetName photo:targetPhoto];
        [targetObjects addObject:target];
    }
    
    id userID = [[info valueForKey:@"member"] valueForKey:@"memberId"];
    NSURL *imageurl = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.200.120.14:8080/member/photo/%@",userID]];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageurl];
    UIImage *userPhoto = [UIImage imageWithData:imageData];
    
    info = [info valueForKey:@"member"];
    
    NSString *firstName = [info valueForKey:@"firstName"];
    
    
    // Create new user using json from server
    MPAUser *currentUser = [[MPAUser alloc] initWithFirstName:[info valueForKey:@"firstName"]
                                                     lastName:[info valueForKey:@"lastName"]
                                                     username:[info valueForKey:@"username"]
                                                        email:[info valueForKey:@"email"]
                                                      targets:targetObjects
                                                        photo:userPhoto
                                                       userId:[[info valueForKey:@"memberId"] intValue]];
    
    MPAPageViewController *pageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pageVC"];
    pageVC.currentUser = currentUser;
    pageVC.loginVC = self;
    [self presentViewController:pageVC animated:YES completion:nil];

    
}

@end


