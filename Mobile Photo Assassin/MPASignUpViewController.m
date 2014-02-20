//
//  MPASignUpViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAShootViewController.h"

@interface MPASignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *verify;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@end

@implementation MPASignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.imageView.contentMode =UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed: @"placeholder.png"];
    [self.imageView setImage:image];
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

- (IBAction)selectPhoto {
    MPAShootViewController *shootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShootVC"];
    shootVC.signUpVC = self;
    [self presentViewController:shootVC animated:YES completion:nil];
}


- (IBAction)signUp {
    if(![self.password.text isEqualToString:self.verify.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Your passwords do no match"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&firstname=%@&lastname=%@&email=%@", self.userName.text, self.password.text, self.firstName.text, self.lastName.text, self.email.text];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://54.200.120.14:8080/member/createAccount"]];
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
    
    NSLog(@"%@", [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]);
    
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:nil];
    
    // If the json doesn't have user information, send alert to user
    if (info == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Could not create account"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Account successfully created!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end




