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

- (id)initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
                  email:(NSString *)email
               password:(NSString *)password
                 target:(MPAUser *)target {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _password = password;
        _target = target;
    }
    return self;
}

@end
