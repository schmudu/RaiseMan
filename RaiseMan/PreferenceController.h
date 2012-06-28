//
//  PreferenceController.h
//  RaiseMan
//
//  Created by PATRICK LEE on 6/28/12.
//  Copyright (c) 2012 Patrick Lee. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSWindowController{
    IBOutlet NSColorWell *colorWell;
    IBOutlet NSButton *checkbox;
}

- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;


@end
