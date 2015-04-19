//
//  main.m
//  LinkedList
//
//  Created by Jakub Skierbiszewski on 04/16/2015.
//  Copyright (c) 2015 Jakub Skierbiszewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"
#import "ListTestDef.h"
#import "ASList.h"
#import "LinkedNode.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello world!");
        
        
        ASList *tmpList = [[ASList alloc]init];
        
        NSString *tmpNode1 = [[NSString alloc]init];
        NSString *tmpNode2 = [[NSString alloc]init];
        NSString *tmpNode3 = [[NSString alloc]init];
        NSString *tmpNode4 = [[NSString alloc]init];
        tmpNode1 = @"Object1";
        tmpNode2 = @"Object2";
        tmpNode3 = @"Object3";
        tmpNode4 = @"Object4";
        [tmpList add:tmpNode1];
        [tmpList add:tmpNode2];
        [tmpList add:tmpNode3];
        [tmpList add:tmpNode4];
        
        
        NSLog(@"Size %ld",[tmpList size]);
        
        
        
    }
    return 0;
}
