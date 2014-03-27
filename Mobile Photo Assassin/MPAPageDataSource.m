//
//  MPAPageDataSource.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/13/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAPageDataSource.h"
#import "MPAPageViewController.h"

@implementation MPAPageDataSource


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [(MPAPageViewController*)pageViewController before:viewController];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [(MPAPageViewController*)pageViewController after:viewController];
}
//
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return [(MPAPageViewController*)pageViewController presentationCountForPageViewController:pageViewController];
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return [(MPAPageViewController*)pageViewController presentationIndexForPageViewController:pageViewController];
//}

@end
