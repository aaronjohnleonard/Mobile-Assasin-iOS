//
//  MPAPageViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/8/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAPageViewController.h"
#import "MPAHomeViewController.h"
#import "MPAMenuViewController.h"

@interface MPAPageViewController ()

@end

@implementation MPAPageViewController

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
    MPAHomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    MPAMenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [self setViewControllers:[[NSArray alloc] initWithObjects:homeVC, nil] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
