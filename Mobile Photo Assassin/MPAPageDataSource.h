//
//  MPAPageDataSource.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/13/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPAPageViewController.h"

@interface MPAPageDataSource : NSObject <UIPageViewControllerDataSource>

@property (strong, nonatomic) MPAPageViewController *pageVC;

@end
