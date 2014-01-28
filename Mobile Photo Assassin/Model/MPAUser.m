//
//  MPAUser.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAUser.h"

@implementation MPAUser

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _firstName = name;
    }
    return self;
}

@end
