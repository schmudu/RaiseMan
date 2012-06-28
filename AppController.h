//
//  AppController.h
//  RaiseMan
//
//  Created by PATRICK LEE on 6/28/12.
//  Copyright (c) 2012 Patrick Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PreferenceController;

@interface AppController : NSObject{
    PreferenceController *preferenceController;
}

- (IBAction)showPreferencePanel:(id)sender;

@end
