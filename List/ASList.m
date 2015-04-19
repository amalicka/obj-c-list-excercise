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

#pragma mark ASList custommethods
-(void)forward{
    if(self.currentNode == nil) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"fwd_No currentNode object" userInfo:nil];
    }
    if(self.currentNode.next == nil){
        return;
    }
    else{
        while(self.currentNode.next !=nil){
            self.currentNode = self.currentNode.next;
        }
        return;
    }
}
-(void)rewind{
    if(self.currentNode == nil) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"rewd_No currentNode object" userInfo:nil];
    }
    if(self.currentNode.prev == nil){
        return;
    }
    else{
        while(self.currentNode.prev != nil){
            self.currentNode = self.currentNode.prev;
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
    }
    else if(self.currentNode == nil){
        nodeToAdd.prev = nil;
        nodeToAdd.next = nil;
        self.currentNode = nodeToAdd;
        //NSLog(@"Added first. prev: %@, next: %@", nodeToAdd.prev, nodeToAdd.next);
        return  true;
    }
    else{
        nodeToAdd.prev = self.currentNode;
        nodeToAdd.next = nil;
        self.currentNode.next = nodeToAdd;
        self.currentNode = nodeToAdd;
        //NSLog(@"Added. prev: %@, next: %@", nodeToAdd.prev, nodeToAdd.next);

        return true;
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
            nodeToAdd.next = self.currentNode;
            self.currentNode.prev = nodeToAdd;
            return;
        }
        NSInteger counter = 0;
        while(counter!=location-1){
            ++counter;
            self.currentNode = self.currentNode.next;
        }
        LinkedNode *nodeToAdd = [[LinkedNode alloc]init];
        nodeToAdd.object = object;
        nodeToAdd.prev = self.currentNode;
        nodeToAdd.next = self.currentNode.next;
        self.currentNode.next = nodeToAdd;
    }
    
}
- (BOOL) addAll:(id<List>) objectList{
    return true;
}

- (BOOL) addAll:(id<List>) objectList atLocation:(NSUInteger) location{
    return true;
}

- (NSUInteger) size{
    NSUInteger counter = 0;
    if(self.currentNode == nil){
        return counter;
    }
    else{
        [self rewind]; //set currentNode for the first element of the list
        counter = 1;
        while(self.currentNode.next !=nil){
            ++counter;
            self.currentNode = self.currentNode.next;
        }
        NSLog(@"Returning size: %ld", counter);
        return counter;
    }
}
- (BOOL) isEmpty{
    if([self size]==0){
        return true;
    }
    else return false;
}

- (id) get:(NSUInteger) location{
    if(location >= [self size] || [self isEmpty]){
        @throw [NSException exceptionWithName:NSRangeException reason:@"get_location out of list range" userInfo:nil];
    }
    NSInteger counter = 0;
    [self rewind];
    while(counter != location){
        self.currentNode = self.currentNode.next;
        counter++;
    }
    return self.currentNode.object;
    
    return nil;
}
- (id) set:(id) object atLocation:(NSUInteger) location{
    return nil;
}

- (BOOL) contains:(id) object{
    return true;
}

- (BOOL) containsAll:(id<List>) objectList{
    return true;
}

- (NSUInteger) locationOf:(id) object{
    return 1;
}

- (NSUInteger) lastLocationOf:(id) object{
    return 1;
}

- (void) clear{
    if(self.currentNode == nil){
        return;
    }
    [self forward];
    while([self size]!=1){
        self.currentNode = self.currentNode.prev;
        self.currentNode.next = nil;
    }
    self.currentNode=nil;
}

- (BOOL) remove:(id) object{
    return true;
}

- (id) removeAtLocation:(NSUInteger) location{
    return nil;
}

- (BOOL) removeAll:(id<List>) objectList{
    return true;
}

- (BOOL) retainAll:(id<List>) objectList{
    return true;
}

- (id<List>) subListFromLocation:(NSUInteger) startLocation toLocation:(NSUInteger) endLocation{
    return nil;
}

- (NSArray*) toArray{
    return nil;
}

- (BOOL) isEqual:(id)other{
    return true;
}
- (NSUInteger) hash{
    return 1;
}
@end
