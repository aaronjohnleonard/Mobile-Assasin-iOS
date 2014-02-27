//
//  MPAMenuViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/8/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAMenuViewController.h"

@interface MPAMenuViewController ()

@property (retain, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *email;

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
    
    //assume that the image is loaded in landscape mode from server
    if (self.user.photo.size.height < self.user.photo.size.width)
    {
        UIImage * PortraitImage = [[UIImage alloc] initWithCGImage: self.user.photo.CGImage scale: 1.0 orientation: UIImageOrientationRight];
        [self.userPhoto setImage:PortraitImage];
    }
    else {
        [self.userPhoto setImage:self.user.photo];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendPhoto:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Join" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    NSData *imageData = UIImageJPEGRepresentation(theImage, 1.0);
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[imageData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://54.200.120.14:8080/game/1/target/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:imageData];
}

- (void)dealloc {
}
@end






