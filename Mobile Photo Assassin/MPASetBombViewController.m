//
//  MPASetBombViewController.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/18/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPASetBombViewController.h"
#import "MPALocationPicker.h"

@interface MPASetBombViewController ()
@property (strong, nonatomic)NSArray *items;
@end

@implementation MPASetBombViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // stuff
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = [[NSArray alloc]initWithObjects:@"item1", @"item2", @"item3", @"item4", nil];
    self.location.delegate = self;
    self.location.dataSource = self;
    NSLog(@"numRows: %ld, firstTitle: %@", (long)[self pickerView:self.location numberOfRowsInComponent:1],[self pickerView:self.location titleForRow:1 forComponent:0]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.items count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.items objectAtIndex:row];
}

@end
