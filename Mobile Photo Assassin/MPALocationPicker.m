//
//  MPALocationPicker.m
//  Mobile Photo Assassin
//
//  Created by Aaron Leonard on 1/20/14.
//  Copyright (c) 2014 Aaron Leonard. All rights reserved.
//

#import "MPALocationPicker.h"

@interface MPALocationPicker()
@property (strong, nonatomic)NSArray *items;
@end

@implementation MPALocationPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    _items = [NSArray arrayWithObject:@"hello"];

    return self;
}

- (NSInteger)numberOfComponents{
    return 1;
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component{
    return [_items count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_items objectAtIndex:row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
