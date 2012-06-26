//
//  RMDocument.m
//  RaiseMan
//
//  Created by PATRICK LEE on 6/23/12.
//  Copyright (c) 2012 Patrick Lee. All rights reserved.
//

#import "RMDocument.h"
#import "Person.h"


@implementation RMDocument
static void *RMDocumentKVOContext;

- (id)init
{
    self = [super init];
    if (self) {
        employees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (IBAction)createEmployee:(id)sender{
    NSWindow *w = [tableView window];
    
    BOOL editingEnded = [w makeFirstResponder:w];
    if (!editingEnded){
        NSLog(@"Unable to end editing");
        return;
    }
    NSUndoManager *undo = [self undoManager];
    
    if ([undo groupingLevel] > 0){
        //close the last group
        [undo endUndoGrouping];
        
        //open a new group
        [undo beginUndoGrouping];
    }
    
    Person *p = [employeeController newObject];
    //add it to the content array of the 'employee controller'
    [employeeController addObject:p];
    
    //re-sort
    [employeeController rearrangeObjects];
    
    //get the sorted array
    NSArray *a = [employeeController arrangedObjects];
    
    //find the object just added
    NSUInteger row = [a indexOfObjectIdenticalTo:p];
    NSLog(@"starting edit of %@ in row %lu", p, row);
    
    //begin edit in the first column
    [tableView editColumn:0 row:row withEvent:nil select:YES];
}

- (void)startObservingPerson:(Person *)person{
    [person addObserver:self forKeyPath:@"personName" options:NSKeyValueObservingOptionOld context:&RMDocumentKVOContext];
    [person addObserver:self forKeyPath:@"expectedRaise" options:NSKeyValueObservingOptionOld context:&RMDocumentKVOContext];
}

- (void)stopObservingPerson:(Person *)person{
    [person removeObserver:self forKeyPath:@"personName" context:&RMDocumentKVOContext];
    [person removeObserver:self forKeyPath:@"expectedRaise" context:&RMDocumentKVOContext];
}

- (void)setEmployees:(NSMutableArray *)a{
    if (a == employees)
        return;
    employees = a;
}

- (void)insertObject:(Person *)p inEmployeesAtIndex:(NSUInteger)index{
    NSLog(@"adding %@ to %@", p, employees);
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex:index];
    
    if (![undo isUndoing]){
        [undo setActionName:@"Add Person"];
    }
    
    //add person to the array
    [self startObservingPerson:p];
    [employees insertObject:p atIndex:index];
}

- (void)removeObjectFromEmployeesAtIndex:(NSUInteger)index{
    Person *p = [employees objectAtIndex:index];
    NSLog(@"removing %@ from %@", p, employees);
    
    //add inverse of this operation to the undo stack
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:p inEmployeesAtIndex:index];
    
    if(![undo isUndoing]){
        [undo setActionName:@"Remove Person"];
    }
    
    [self stopObservingPerson:p];
    [employees removeObjectAtIndex:index];
    
}

- (void)changeKeyPath:(NSString *)keyPath ofObject:(id)obj toValue:(id)newValue{
    [obj setValue:newValue forKeyPath:keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context != &RMDocumentKVOContext){
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
    NSUndoManager *undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    
    if (oldValue == [NSNull null]){
        oldValue = nil;
    }
    NSLog(@"oldValue = %@", oldValue);
    [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath ofObject:object toValue:oldValue];
    [undo setActionName:@"Edit"];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"RMDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

@end
