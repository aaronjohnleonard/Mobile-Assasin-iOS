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
@property (strong, nonatomic) IBOutlet UIImageView *targetImage;
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
    
    NSURL *imageurl = [NSURL URLWithString:@"http://leonard.tk/app/mobileAssassin/image"];
    
    NSData *imagedata = [[NSData alloc] initWithContentsOfURL:imageurl];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Join" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    
    UIImage *image = [UIImage imageWithData: imagedata];
    
    [self saveImageToServer];
    
    [self.targetImage setImage:theImage];
    
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
}

- (void)saveImageToServer {
    
    // Query server using inputted credentials
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://leonard.tk/app/mobileAssassin/aaronleonard/password"]]
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
    /*
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Join" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    NSData *imageData = UIImageJPEGRepresentation(theImage,90);
    NSString *urlString = @"leonard.tk/app/mobileAssassin/aaronleonard/password/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:30];
    //[request setURL:[NSURL URLWithString:urlString]];
    //[request setHTTPMethod:@"POST"];
    
    /*
    NSMutableData *body = [NSMutableData data];
    [body appendData:[NSData dataWithData:imageData]];
    [request setHTTPBody:body];
    
     
    NSURLResponse *response;
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", returnString);
    */
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Join" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    NSData *imageData = UIImageJPEGRepresentation(theImage,90);
    //NSString *urlString = @"URL 1/upload.php";
    NSString *urlString = @"leonard.tk/app/uploadImage";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"_187934598797439873422234";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    *///[request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    /*[request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.26.14 (KHTML, like Gecko) Version/6.0.1 Safari/536.26.14" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"http://google.com" forHTTPHeaderField:@"Origin"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"picture\"; filename=\"%@.jpg\"\r\n", @"TESTTEST"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", returnString);
    */
}


@end















