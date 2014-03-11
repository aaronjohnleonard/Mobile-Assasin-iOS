//
//  MPAJoinViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 2/25/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAJoinViewController.h"
#import "MPAGame.h"

@interface MPAJoinViewController ()

@property (strong, nonatomic) NSMutableArray* games;
@property (strong, nonatomic) NSMutableArray* joinButtons;

@end

@implementation MPAJoinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.games = [[NSMutableArray alloc] init];
    self.joinButtons = [[NSMutableArray alloc] init];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    NSMutableURLRequest *inforequest = [[NSMutableURLRequest alloc] init];
    [inforequest setURL:[NSURL URLWithString:@"http://54.200.120.14:8080/game/getGames"]];
    
    urlData = [NSURLConnection sendSynchronousRequest:inforequest
                                    returningResponse:&response
                                                error:&error];
    
    NSArray *games = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:nil];
    
   // NSArray* games = [[NSArray alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://54.200.120.14:8080/game/getGames"]];
    
    for (int i = 0; i < games.count; i++) {
        NSDictionary* game = games[i];
        MPAGame* gameObj = [[MPAGame alloc] initWithId:[[game valueForKey:@"gameId"] intValue]  completed:[game valueForKey:@"completion"] hasStarted:[game valueForKey:@"hasStarted"] name:[game valueForKey:@"gameName"] numPlayers:[[game valueForKey:@"numberOfPlayersInGame"] intValue] creatorId:[[[game valueForKey:@"creator"] valueForKey:@"memberId"] intValue]];
        [self.games addObject:gameObj];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)joinTapped:(id)sender {
    if ([[(UIButton*)sender titleLabel].text isEqualToString:@"Join"]) {
        NSInteger index = [self.joinButtons indexOfObject:sender];
        MPAGame *gameToJoin = [self.games objectAtIndex:index];
        NSData *urlData;
        NSURLResponse *response;
        NSError *error;
        
        NSMutableURLRequest *joinGameRequest = [[NSMutableURLRequest alloc] init];
        [joinGameRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://54.200.120.14:8080/game/join/%ld", gameToJoin.gameId]]];
        [joinGameRequest setHTTPMethod:@"POST"];
        
        urlData = [NSURLConnection sendSynchronousRequest:joinGameRequest
                                        returningResponse:&response
                                                    error:&error];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        ((UIButton *)sender).hidden = YES;
    }
    else if ([[(UIButton*)sender titleLabel].text isEqualToString:@"Start"]){
        NSInteger index = [self.joinButtons indexOfObject:sender];
        MPAGame *gameToStart = [self.games objectAtIndex:index];
        NSData *urlData;
        NSURLResponse *response;
        NSError *error;
        
        NSMutableURLRequest *startGameRequest = [[NSMutableURLRequest alloc] init];
        [startGameRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://54.200.120.14:8080/game/startGame/%ld", gameToStart.gameId]]];
        [startGameRequest setHTTPMethod:@"POST"];
        
        urlData = [NSURLConnection sendSynchronousRequest:startGameRequest
                                        returningResponse:&response
                                                    error:&error];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        ((UIButton *)sender).hidden = YES;

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.games.count;
}
- (IBAction)backTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MPAGame *thisGame = [self.games objectAtIndex:[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameTableCell"];
    UILabel *gameName = (UILabel *)[cell viewWithTag:100];
    if ([[thisGame gameName] class] == [[NSNull null] class]) {
        [gameName setText:@"null"];
    }else{
        [gameName setText:[thisGame gameName]];
    }
    
    UIButton *actionButton = (UIButton *)[cell viewWithTag:101];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    NSMutableURLRequest *inforequest = [[NSMutableURLRequest alloc] init];
    [inforequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://54.200.120.14:8080/game/canJoinGame/%ld",(long)[thisGame gameId]]]];
    urlData = [NSURLConnection sendSynchronousRequest:inforequest
                                    returningResponse:&response
                                                error:&error];
    NSString* canJoin = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    if ([canJoin isEqualToString:@"true"]) {
        actionButton.hidden = NO;
    }
    else{
        actionButton.hidden = YES;
    }
    if (thisGame.creatorId == self.currentUser.userId) {
        [actionButton setTitle:@"Start" forState:UIControlStateNormal];
        actionButton.hidden = NO;
    }
    
    [self.joinButtons addObject:actionButton];
    
    return cell;
}

@end
