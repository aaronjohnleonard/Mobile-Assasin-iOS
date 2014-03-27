//
//  MPAUser.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAUser.h"

@implementation MPAUser

-(id) initWithName:(NSString *)name
             photo:(UIImage*)photo
            gameId:(NSString *)gameId{
    self = [super init];
    if (self) {
        _firstName = name;
        _photo = photo;
        _gameId = gameId;
    }
    return self;
}

- (id)initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
               username:(NSString *)username
                  email:(NSString *)email
                targets:(NSMutableArray *)targets
                  photo:(UIImage*)photo
                 userId:(NSInteger)userId{
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _username = username;
        _email = email;
        _targets = targets;
        _photo = photo;
        _userId = userId;
    }
    return self;
}

@end
