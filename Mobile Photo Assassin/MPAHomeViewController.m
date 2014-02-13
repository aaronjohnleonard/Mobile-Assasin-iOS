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
    
    self.usernameLabel.text = self.currentUser.email;
    self.target.text = self.currentUser.target.firstName;
    
    NSURL *imageurl = [NSURL URLWithString:@"http://leonard.tk/app/mobileAssassin/image"];
    
    NSData *imagedata = [[NSData alloc] initWithContentsOfURL:imageurl];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Join" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    
    UIImage *image = [UIImage imageWithData: imagedata];
    
    //[self saveImageToServer];
    
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

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    return [self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    return nil;
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 1;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}


@end















