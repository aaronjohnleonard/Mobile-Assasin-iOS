//
//  MPAShootTargetViewController.m
//  Mobile Photo Assassin
//
//  Created by Caleb Call on 3/2/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAShootTargetViewController.h"

@interface MPAShootTargetViewController ()
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIImage *image;;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MPAShootTargetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed: @"placeholder.png"];
    [self.imageView setImage:image];
    //[self TakePhoto];
}

- (IBAction)TakePhoto {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)sendPhoto {
    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
   
    //NSMutableArray *game = [[NSMutableArray alloc] init];
    //[game addObject:self.gameId];
    
    [_params setObject:self.gameId forKey:@"game"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"photo";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString:@"http://54.200.120.14:8080/target/assassinate"];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:YES];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response
                                                error:&error];
    
    NSString *replyString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", replyString);
    
    NSDictionary *targetData = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:nil];
    
    // If the json doesn't have user information, send alert to user
    if (targetData == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Assassination successful. You win!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        UIImage *winnerPhoto = [UIImage imageNamed: @"champion.jpg"];
        MPAUser *winner = [[MPAUser alloc] initWithName:@"YOU WIN!" photo:winnerPhoto gameId:self.targetVC.gameId];
        self.targetVC.user.targets[self.targetVC.targetIndex] = winner;
        [self.targetVC viewDidLoad];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Assassination successful"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        targetData = [targetData valueForKey:@"target"];
        
        // create the new target and replace the old one in the target array for the user
        NSString *targetName = [targetData valueForKey:@"firstName"];
        id targetID = [targetData valueForKey:@"memberId"];
        
        NSURL *imageurl = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.200.120.14:8080/member/photo/%@",targetID]];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageurl];
        UIImage *targetPhoto = [UIImage imageWithData:imageData];
        MPAUser *target = [[MPAUser alloc] initWithName:targetName photo:targetPhoto gameId:self.targetVC.gameId];
        
        self.targetVC.user.targets[self.targetVC.targetIndex] = target;
        [self.targetVC viewDidLoad];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
