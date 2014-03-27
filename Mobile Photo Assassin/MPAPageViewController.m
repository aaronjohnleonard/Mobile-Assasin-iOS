//
//  MPAPageViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/8/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAPageViewController.h"
#import "MPATargetViewController.h"
#import "MPAMenuViewController.h"
#import "MPAPageDataSource.h"

@interface MPAPageViewController ()

@property (strong, nonatomic) NSMutableArray *targetVCs;
@property (strong, nonatomic) MPAMenuViewController *menuVC;
@property (strong, nonatomic) MPAPageDataSource *data;

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
    self.data = [[MPAPageDataSource alloc] init];
    self.data.pageVC = self;
    self.targetVCs = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.currentUser.targets count]; i++) {
        MPATargetViewController *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TargetVC"];
        targetVC.username = self.currentUser.username;
        targetVC.user = self.currentUser;
        targetVC.pageVC = self;
        targetVC.targetIndex = i;
        targetVC.gameId = ((MPAUser *)self.currentUser.targets[i]).gameId;
        [self.targetVCs addObject:targetVC];
    }
    self.menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    self.menuVC.user = self.currentUser;
    self.menuVC.parent = self;
    self.dataSource = self.data;
    [self setViewControllers:[[NSArray alloc] initWithObjects:self.menuVC, nil] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController*) before:(UIViewController*)controller{
    if(controller == self.menuVC){
        return nil;
    }
    else{
        NSInteger index = [self.targetVCs indexOfObject:controller];
        
        if (index == 0) {
            return self.menuVC;
        }
        else{
            return self.targetVCs[index - 1];
        }
    }
}

- (UIViewController*) after:(UIViewController*)controller{
    if(controller == self.menuVC){
        if ([self.targetVCs count] == 0) {
            return nil;
        }
        return self.targetVCs[0];
    }
    else{
        NSInteger index = [self.targetVCs indexOfObject:controller];
        
        if (index == [self.targetVCs count] - 1) {
            return nil;
        }
        return self.targetVCs[index + 1];
    }
}
//
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return [self.targetVCs count] + 1;
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 0;
//}

- (NSInteger)numPages{
    return [self.targetVCs count] + 1;
}

- (NSInteger)currentPageForViewController:(MPAHomeViewController*)targetVC{
    return [self.targetVCs indexOfObject:targetVC] + 1;
}

- (IBAction)logoutTapped{
    [self performSegueWithIdentifier:@"unwindToWelcome" sender:self];
}

@end








