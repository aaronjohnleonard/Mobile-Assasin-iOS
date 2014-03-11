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
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSArray *targets;
@property (strong, nonatomic) UIImage *photo;

// used for assassinating
@property (strong, nonatomic) NSString *gameId;

-(id) initWithName:(NSString *)name
             photo:(UIImage*)photo
            gameId:(NSString *)gameId;
-(id) initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
               username:(NSString *)username
                  email:(NSString *)email
                targets:(NSArray *)targets
                  photo:(UIImage*)photo;

@end
