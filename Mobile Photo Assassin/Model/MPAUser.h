//
//  MPAUser.h
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/17/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPAUser : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) MPAUser *target;

-(id) initWithName:(NSString *)name;
-(id) initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
                  email:(NSString *)email
               password:(NSString *)password
                 target:(MPAUser *)target;

@end
