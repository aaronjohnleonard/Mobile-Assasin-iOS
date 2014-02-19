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
    
    [self.userPhoto setImage:self.user.photo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CreateTapped:(id)sender {
    int x = 5;
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






