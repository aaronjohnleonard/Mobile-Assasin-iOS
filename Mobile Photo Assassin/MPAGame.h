//
//  MPAGame.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/25/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPAUser.h"

@interface MPAGame : NSObject

@property (nonatomic) NSInteger gameId;
@property (strong, nonatomic) MPAUser* creator;
@property (nonatomic) BOOL completed;
@property (nonatomic) BOOL hasStarted;
@property (nonatomic) NSString* gameName;
@property (nonatomic) NSInteger numPlayers;

- (id)initWithId:(NSInteger)Id
       completed:(BOOL)completed
      hasStarted:(BOOL)hasStarted
            name:(NSString*)name
      numPlayers:(NSInteger)numPlayers;

@end
