//
//  MPAShootViewController.m
//  Mobile Photo Assassin
//
//  Created by Caleb Call on 2/4/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPAShootViewController.h"

@interface MPAShootViewController ()

@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIImagePickerController *picker2;
@property (strong, nonatomic) UIImage *image;;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MPAShootViewController

- (IBAction)TakePhoto {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.picker animated:YES completion:NULL];
}

- (IBAction)chooseExisting {
    self.picker2 = [[UIImagePickerController alloc] init];
    self.picker2.delegate = self;
    [self.picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.picker2 animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.image];
    NSData *pngData = UIImagePNGRepresentation(self.image);
    NSString *filePath = [self documentsPathForFileName:@"image.png"];
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)loadImageButton:(UIButton *)sender {
    NSString *filePath = [self documentsPathForFileName:@"image.png"];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *localImage = [UIImage imageWithData:pngData];
    
    self.imageView.image = localImage;
}

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

- (IBAction)finished {
    [self.signUpVC.imageView setImage:self.image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
