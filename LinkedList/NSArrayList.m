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
    
}

- (BOOL) addAll:(id<List>) objectList {
    return false;
}

- (BOOL) addALl:(id<List>) objectList atLocation:(NSUInteger) location {
    return false;
}

- (void) clear {
    
}

- (BOOL) contains:(id) object {
    return false;
}

- (BOOL) containsAll:(id<List>) objectList {
    return false;
}

- (id) get:(NSUInteger) location {
    return [_array objectAtIndex:location];
}

- (NSUInteger) locationOf:(id) object {
    return 0;
}

- (NSUInteger) lastLocationOf:(id) object {
    return 0;
}

- (BOOL) isEmpty {
    return _array.count == 0;
}

- (id) removeAtLocation:(NSUInteger) location {
    return nil;
}

- (BOOL) remove:(id) object {
    return false;
}

- (BOOL) removeAll:(id<List>) objectList {
    return false;
}

- (BOOL) retainAll:(id<List>) objectList {
    return false;
}

- (id) set:(id) object atLocation:(NSUInteger) location {
    return nil;
}

- (NSUInteger) size {
    return _array.count;
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
