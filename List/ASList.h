//
//  ASList.h
//  List
//
//  Created by Ola Skierbiszewska on 18/04/15.
//  Copyright (c) 2015 Jakub Skierbiszewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"
#import "LinkedNode.h"

@interface ASList : NSObject <List>
@property (nonatomic, strong) LinkedNode *currentNode;

-(void)forward;
-(void)rewind;

@end
