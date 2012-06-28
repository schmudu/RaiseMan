//
//  PreferenceController.m
//  RaiseMan
//
//  Created by PATRICK LEE on 6/28/12.
//  Copyright (c) 2012 Patrick Lee. All rights reserved.
//

#import "PreferenceController.h"

@interface PreferenceController ()

@end

@implementation PreferenceController

- (id)init{
    self = [super initWithWindowNibName:@"Preferences"];
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSLog(@"Nib file is loaded");
}

- (IBAction)changeBackgroundColor:(id)sender{
    NSColor *color = [colorWell color];
    NSLog(@"Color changed: %@", color);
}

- (IBAction)changeNewEmptyDoc:(id)sender{
    NSInteger state = [checkbox state];
    NSLog(@"Checkbox changed %ld", state);
}

@end
