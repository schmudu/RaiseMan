//
//  Person.m
//  RaiseMan
//
//  Created by PATRICK LEE on 6/23/12.
//  Copyright (c) 2012 Patrick Lee. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize personName;
@synthesize expectedRaise;

- (id)init{
    self = [super init];
    if (self){
        expectedRaise = 0.05;
        personName = @"New person";
    }
    return self;
}


- (void)setNilValueForKey:(NSString *)key{
    if ([key isEqual:@"expectedRaise"]){
        [self setExpectedRaise:0.0];
    } else{
        [super setNilValueForKey:key];
    }
}
@end
