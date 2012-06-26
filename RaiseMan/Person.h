//
//  Person.h
//  RaiseMan
//
//  Created by PATRICK LEE on 6/23/12.
//  Copyright (c) 2012 Patrick Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>{
    NSString *personName;
    float expectedRaise;
}

@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;

@end
