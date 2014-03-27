//
//  MPAMenuViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/8/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAMenuViewController.h"
#import "MPAJoinViewController.h"

@interface MPAMenuViewController ()

@property (retain, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIPageControl *dots;

@end

@implementation MPAMenuViewController

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
    
    self.username.text = self.user.username;
    self.name.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
    self.email.text = self.user.email;
    
    self.userPhoto.contentMode = UIViewContentModeScaleAspectFit;
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    //assume that the image is loaded in landscape mode from server
    if (self.user.photo.size.height < self.user.photo.size.width)
    {
        UIImage * PortraitImage = [[UIImage alloc] initWithCGImage: self.user.photo.CGImage scale: 1.0 orientation: UIImageOrientationRight];
        [self.userPhoto setImage:PortraitImage];
    }
    else {
        [self.userPhoto setImage:self.user.photo];
    }
    
    self.dots.numberOfPages = [self.parent numPages];
    self.dots.currentPage = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutTapped:(id)sender {
    [self.parent logoutTapped];
}
- (IBAction)joinButtonTapped:(id)sender {
    MPAJoinViewController *joinVC = [self.storyboard instantiateViewControllerWithIdentifier:@"joinVC"];
    joinVC.currentUser = self.user;
    [self presentViewController:joinVC animated:YES completion:nil];
}

- (void)dealloc {
}
@end






