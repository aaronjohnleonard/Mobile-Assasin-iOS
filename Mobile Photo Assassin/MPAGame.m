//
//  MPAGame.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/25/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAGame.h"

@implementation MPAGame

- (id)initWithId:(NSInteger)Id
       completed:(NSInteger)completed
      hasStarted:(NSInteger)hasStarted
            name:(NSString*)name
      numPlayers:(NSInteger)numPlayers
       creatorId:(NSInteger)creatorId
        joinable:(BOOL)joinable
       startable:(BOOL)startable
{
    self = [super init];
    if (self) {
        _gameId = Id;
        _completed = completed;
        _hasStarted = hasStarted;
        _gameName = name;
        _numPlayers = numPlayers;
        _creatorId = creatorId;
        _joinable = joinable;
        _startable = startable;
    }
    return self;
}

@end
