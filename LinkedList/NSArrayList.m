//
//  NSArrayList.m
//  List
//
//  Created by Jakub Skierbiszewski on 04/16/2015.
//  Copyright (c) 2015 Jakub Skierbiszewski. All rights reserved.
//
#import "NSArrayList.h"

@implementation NSArrayList {
    NSMutableArray *_array;
}

- (id) init {
    self = [super init];
    if (self) {
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL) add:(id)object {
    [_array addObject:object];
    return true;
}

- (void) add:(id)object atLocation:(NSUInteger)location {
    if (location > [self size]) {
        @throw [NSException
                exceptionWithName:NSRangeException
                reason:@"Cannot insert at location > size!!!"
                userInfo: nil];
    }
    
    [_array insertObject:object atIndex:location];
}

- (BOOL) addAll:(id<List>) objectList {
    if (objectList == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil objectList!"
                userInfo:nil];
    }
    
    if ([objectList isEmpty]) {
        return false;
    }
    
    [_array addObjectsFromArray:[objectList toArray]];
    return true;
}

- (BOOL) addAll:(id<List>) objectList atLocation:(NSUInteger) location {
    if (objectList == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil objectList!"
                userInfo:nil];
    }
    
    if (location > [self size]) {
        @throw [NSException
                exceptionWithName:NSRangeException
                reason:@"Cannot insert at location > size!!!"
                userInfo: nil];
    }
    
    if ([objectList isEmpty]) {
        return false;
    }
    
    for (NSUInteger i = 0; i < [objectList size]; ++i) {
        [self add:[objectList get:i] atLocation:location+i];
    }
    
    return true;
}

- (NSUInteger) size {
    return _array.count;
}

- (BOOL) isEmpty {
    return _array.count == 0;
}

- (id) get:(NSUInteger) location {
    return [_array objectAtIndex:location];
}

- (id) set:(id) object atLocation:(NSUInteger) location {
    return nil;
}

- (BOOL) contains:(id) object {
    if (object == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil object!"
                userInfo:nil];
    }
    return [_array containsObject:object];
}

- (BOOL) containsAll:(id<List>) objectList {
    if (objectList == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil list!"
                userInfo:nil];
    }
    
    for (NSUInteger i = 0; i < [objectList size]; ++i) {
        id obj = [objectList get:i];
        if ([_array containsObject:obj] == NO) {
            return false;
        }
    }
    return true;
}

- (NSUInteger) locationOf:(id) object {
    if (object == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil object!"
                userInfo:nil];
    }
    return [_array indexOfObject:object];
}

- (NSUInteger) lastLocationOf:(id) object {
    if (object == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil object!"
                userInfo:nil];
    }
    NSUInteger location = NSNotFound;
    for (NSUInteger i = 0; i < _array.count; ++i) {
        if ([[_array objectAtIndex:i] isEqual:object]) {
            location = i;
        }
    }
    return location;
}

- (void) clear {
    [_array removeAllObjects];
}

- (BOOL) remove:(id) object {
    if (object == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil object!"
                userInfo:nil];
    }
    
    for (NSUInteger i = 0; i < _array.count; ++i) {
        if ([[_array objectAtIndex:i] isEqual: object]) {
            [_array removeObjectAtIndex:i];
            return true;
        }
    }
    
    return false;
}

- (id) removeAtLocation:(NSUInteger) location {
    if (location > [self size]) {
        @throw [NSException
                exceptionWithName:NSRangeException
                reason:@"Cannot insert at location > size!!!"
                userInfo: nil];
    }
    
    id removed = [_array objectAtIndex:location];
    [_array removeObjectAtIndex:location];
    return removed;
}

- (BOOL) removeAll:(id<List>) objectList {
    if (objectList == nil) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"Passed nil objectList!"
                userInfo:nil];
    }
    
    NSUInteger prevSize = _array.count;
    [_array removeObjectsInArray:[objectList toArray]];
    return prevSize != _array.count;
}

- (BOOL) retainAll:(id<List>) objectList {
    return false;
}

- (id<List>) subListFromLocation:(NSUInteger) startLocation toLocation:(NSUInteger) endLocation {
    return nil;
}

- (NSArray*) toArray {
    return _array;
}

// Equality checks, see: http://nshipster.com/equality/
- (BOOL) isEqual:(id) other {
    if (self == other) {
        return YES;
    }
    
    if (![other isKindOfClass:[NSArrayList class]]) {
        return NO;
    }
    
    return [self isEqualToArrayList:(other)];
}

- (BOOL) isEqualToArrayList:(id<List>) otherList {
    return [_array isEqual:otherList];
}
- (NSUInteger) hash {
    return [_array hash];
}
@end
