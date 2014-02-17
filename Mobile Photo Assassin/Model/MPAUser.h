//
//  MPAUser.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPAUser : NSObject <UITextViewDelegate>

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSArray *targets;

-(id) initWithName:(NSString *)name;
-(id) initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
               username:(NSString *)username
                 targets:(NSArray *)targets;

@end
