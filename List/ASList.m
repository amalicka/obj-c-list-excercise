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

- (BOOL) add:(id)object{
    LinkedNode *nodeToAdd = [[LinkedNode alloc]init];
    nodeToAdd.object = object;
    
    if(object==nil){
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Added object is nil"
                                     userInfo:nil];
    }
    else if(self.currentNode == nil){
        nodeToAdd.prev = nil;
        nodeToAdd.next = nil;
        self.currentNode = nodeToAdd;
        NSLog(@"Added first. prev: %@, next: %@", nodeToAdd.prev, nodeToAdd.next);
        return  true;
    }
    else{
        NSLog(@"self.currentNode %@",self.currentNode);
        nodeToAdd.prev = self.currentNode;
        nodeToAdd.next = nil;
        self.currentNode.next = nodeToAdd;
        self.currentNode = nodeToAdd;
        NSLog(@"Added. prev: %@, next: %@", nodeToAdd.prev, nodeToAdd.next);

        return true;
    }
}
- (void) add:(id)object atLocation:(NSUInteger)location{
    
}
- (BOOL) addAll:(id<List>) objectList{
    return true;
}

- (BOOL) addAll:(id<List>) objectList atLocation:(NSUInteger) location{
    return true;
}

- (NSUInteger) size{
    NSInteger counter = 0;
    if(self.currentNode == nil){
        return counter;
    }
    else{
        LinkedNode *tmpNode = self.currentNode;
        counter = 1;
        while(tmpNode.prev !=nil){
            ++counter;
            tmpNode = tmpNode.prev;
        }
        
        return counter;
    }
}
- (BOOL) isEmpty{
    return true;
}

- (id) get:(NSUInteger) location{
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
