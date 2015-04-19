//
//  ASList.m
//  List
//
//  Created by Ola Skierbiszewska on 18/04/15.
//  Copyright (c) 2015 Jakub Skierbiszewski. All rights reserved.
//

#import "ASList.h"
#import "LinkedNode.h"

@implementation ASList

@synthesize currentNode = _currentNode;

#pragma mark ASList custommethods
-(void)forward{
    if(_currentNode == nil) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"fwd_No currentNode object" userInfo:nil];
        return;
    }
    if(_currentNode.next == nil){
        return;
    }
    else{
        while(_currentNode.next !=nil){
            _currentNode = _currentNode.next;
        }
        return;
    }
}
-(void)rewind{
//    while(_currentNode.prev != nil){
//        _currentNode = _currentNode.prev;
//    }
    if(_currentNode == nil) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"rewd_No currentNode object" userInfo:nil];
        return;
    }
    if(_currentNode.prev == nil){
        return;
    }
    else{
        while(_currentNode.prev != nil){
            _currentNode = _currentNode.prev;
        }
        return;
    }
}

#pragma mark <List> methods
- (BOOL) add:(id)object{
    LinkedNode *nodeToAdd = [[LinkedNode alloc]init];
    nodeToAdd.object = object;
    
    if(object==nil){
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"as_Added object is nil"
                                     userInfo:nil];
        return NO;
    }
    else if(_currentNode == nil){
        nodeToAdd.prev = nil;
        nodeToAdd.next = nil;
        _currentNode = nodeToAdd;
        NSLog(@"Added object %@", _currentNode.object);
        return  YES;
    }
    else{
        nodeToAdd.prev = _currentNode;
        nodeToAdd.next = nil;
        _currentNode.next = nodeToAdd;
        _currentNode = nodeToAdd;
        NSLog(@"Added object %@", _currentNode.object);

        return YES;
    }
}
- (void) add:(id)object atLocation:(NSUInteger)location{
    if(object==nil){
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"as_Added object is nil"
                                     userInfo:nil];
    }
    if(location > [self size]){
        @throw [NSException exceptionWithName:NSRangeException reason:@"as_Location out of list range" userInfo:nil];
    }
    if(location == [self size]){
        NSInteger tmpSize = [self size];
        [self add: object];
    }
    else{
        NSInteger tmpSize = [self size];
        [self rewind];
        if(location == 0){
            LinkedNode *nodeToAdd = [[LinkedNode alloc]init];
            nodeToAdd.object = object;
            nodeToAdd.prev = nil;
            nodeToAdd.next = _currentNode;
            _currentNode.prev = nodeToAdd;
            return;
        }
        NSInteger counter = 0;
        while(counter!=location-1){
            ++counter;
            _currentNode = _currentNode.next;
        }
        LinkedNode *nodeToAdd = [[LinkedNode alloc]init];
        nodeToAdd.object = object;
        nodeToAdd.prev = _currentNode;
        nodeToAdd.next = _currentNode.next;
        _currentNode.next = nodeToAdd;
    }
    
}
- (BOOL) addAll:(id<List>) objectList{
    return YES;
}

- (BOOL) addAll:(id<List>) objectList atLocation:(NSUInteger) location{
    return YES;
}

- (NSUInteger) size{
    NSUInteger counter = 0;
    LinkedNode *copyOfCurrent = [[LinkedNode alloc]init];
    copyOfCurrent = _currentNode;
    if(copyOfCurrent == nil){
        return counter;
    }
    else{
        //set currentNode for the first element of the list
        while(copyOfCurrent.prev != nil){
            copyOfCurrent = copyOfCurrent.prev;
        }
        counter = 1;
        while(copyOfCurrent.next !=nil){
            ++counter;
            copyOfCurrent = copyOfCurrent.next;
        }
        return counter;
    }
}
- (BOOL) isEmpty{
    if([self size]==0){
        return YES;
    }
    else return NO;
}

- (id) get:(NSUInteger) location{
    if(location >= [self size] || [self isEmpty]){
        @throw [NSException exceptionWithName:NSRangeException reason:@"get_location out of list range" userInfo:nil];
    }
    NSInteger counter = 0;
    [self rewind];
    while(counter != location){
        _currentNode = _currentNode.next;
        counter++;
    }
    return _currentNode.object;
    
    return nil;
}
- (id) set:(id) object atLocation:(NSUInteger) location{
    return nil;
}

- (BOOL) contains:(id) object{
    
    NSLog(@"contains %@", object);
    [self rewind];
    
    LinkedNode *copyOfCurrent = [[LinkedNode alloc]init];
    
    if(object==nil){
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"contains_given object is a nil" userInfo:nil];
        return NO;
    }
    copyOfCurrent = _currentNode;
    while(copyOfCurrent.next != nil){
        if([copyOfCurrent.object isEqualTo:object]){
            return YES;
        }
        else{
            if(copyOfCurrent.next !=nil){
                copyOfCurrent = copyOfCurrent.next;
            }
        }
    }
    return NO;
}

- (BOOL) containsAll:(id<List>) objectList{
    return YES;
}

- (NSUInteger) locationOf:(id) object{
    if(object==nil){
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"contains_given object is a nil" userInfo:nil];
    }
    [self rewind];
    
    LinkedNode *copyOfCurrent = [[LinkedNode alloc]init];
    NSUInteger counter =0;
    copyOfCurrent = _currentNode;
    for(NSInteger i=0; i< [self size]; ++i){
        if([copyOfCurrent.object isEqualTo:object]){
            return counter;
        }
        else{
            if(copyOfCurrent.next !=nil){
                copyOfCurrent = copyOfCurrent.next;
            }
        }
        ++counter;
    }
    return NSNotFound;
}

- (NSUInteger) lastLocationOf:(id) object{
    NSLog(@"location of %@", object);
    if(object==nil){
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:@"contains_given object is a nil"
                userInfo:nil];
    }
    [self rewind];
    
    LinkedNode *copyOfCurrent = [[LinkedNode alloc]init];
    copyOfCurrent = _currentNode;
    
//    for(NSInteger i=0; i< [self size]; ++i){
//        NSLog(@"object %ld: %@", i, copyOfCurrent.object);
//        copyOfCurrent = copyOfCurrent.next;
//    }
    
    NSUInteger counter =0;
    NSUInteger lastOccurenceLocation = NSNotFound;
    copyOfCurrent = _currentNode;
    for(NSInteger i=0; i< [self size]; ++i){
        if([copyOfCurrent.object isEqualTo:object]){
            lastOccurenceLocation = counter;
            if(copyOfCurrent.next !=nil){
                copyOfCurrent = copyOfCurrent.next;
            }
        }
        else{
            if(copyOfCurrent.next !=nil){
                copyOfCurrent = copyOfCurrent.next;
            }
        }
        ++counter;
    }
    if(lastOccurenceLocation!=NSNotFound){
        return lastOccurenceLocation;
    }
    else{
        return NSNotFound;
    }
}

- (void) clear{
    if(_currentNode == nil){
        return;
    }
    [self forward];
    while([self size]!=1){
        _currentNode = _currentNode.prev;
        _currentNode.next = nil;
    }
    _currentNode=nil;
}

- (BOOL) remove:(id) object{
    return YES;
}

- (id) removeAtLocation:(NSUInteger) location{
    return nil;
}

- (BOOL) removeAll:(id<List>) objectList{
    return YES;
}

- (BOOL) retainAll:(id<List>) objectList{
    return YES;
}

- (id<List>) subListFromLocation:(NSUInteger) startLocation toLocation:(NSUInteger) endLocation{
    return nil;
}

- (NSArray*) toArray{
    return nil;
}

- (BOOL) isEqual:(id)other{
    return YES;
}
- (NSUInteger) hash{
    return 1;
}
@end
