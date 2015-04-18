//
//  LinkedNode.h
//  List
//
//  Created by Jakub Skierbiszewski on 04/18/2015.
//  Copyright (c) 2015 Jakub Skierbiszewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkedNode : NSObject

@property LinkedNode *next;
@property LinkedNode *prev;
@property id object;

@end
