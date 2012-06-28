//
//  AppController.m
//  RaiseMan
//
//  Created by PATRICK LEE on 6/28/12.
//  Copyright (c) 2012 Patrick Lee. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (IBAction)showPreferencePanel:(id)sender{
    //Is preferenceController nil?
    if(!preferenceController){
        preferenceController = [[PreferenceController alloc] init];
    }
    
    NSLog(@"showing %@", preferenceController);
    [preferenceController showWindow:self];
}

@end
