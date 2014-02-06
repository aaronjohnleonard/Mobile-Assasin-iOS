//
//  MPATestViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/30/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPATestViewController.h"

@interface MPATestViewController ()
@property (strong, nonatomic) IBOutlet UILabel *firstName;
@property (strong, nonatomic) IBOutlet UILabel *lastName;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *password;

@end

@implementation MPATestViewController

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
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://leonard.tk/app/mobileAssassin"]
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
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
    
    json = [json valueForKey:@"user"];
    
    self.firstName.text = [json valueForKey:@"firstName"];
    self.lastName.text = [json valueForKey:@"lastName"];
    self.email.text = [json valueForKey:@"email"];
    self.password.text = [json valueForKey:@"password"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
