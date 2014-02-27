//
//  MPAGameCreatorController.m
//  Mobile Photo Assassin
//
//  Created by Kris Alder on 14.02.22.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAGameCreatorController.h"

@interface MPAGameCreatorController ()
@property (weak, nonatomic) IBOutlet UITextField *gameName;
@property (weak, nonatomic) IBOutlet UITextField *maxPlayers;

@end

@implementation MPAGameCreatorController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createGame {
    // Verify that the game's name isn't empty.
    if ([self.gameName.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Game Name"
                                                        message:@"You must enter a name for your game."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // Make sure that a valid number of maximum players has been entered.
    if ([self.maxPlayers.text intValue] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Player Count"
                                                        message:@"Please input the maximum number of players."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // Set the POST parameters.
    // TODO: don't have max_size and gameType hardcoded
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:self.maxPlayers.text forKey:@"max_size"];
    [_params setObject:self.gameName.text forKey:@"gameName"];
    [_params setObject:@"1" forKey:@"gameType"];
    
    // Create and populate the body of the POST request.
    NSMutableData *body = [NSMutableData data];
    
    // Add parameters to the body.
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // Create the request.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // Set the URL we'll make the request to.
    NSURL* requestURL = [NSURL URLWithString:@"http://54.200.120.14:8080/game/createGame"];
    [request setURL:requestURL];
    
    // Set Content-Length.
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // Attach the body data to the request.
    [request setHTTPBody:body];
    
    
    
    // Make the request.
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response
                                                error:&error];
    
    NSString *replyString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", replyString);
}

@end
