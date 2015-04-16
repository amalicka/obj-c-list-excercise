//
//  ListTests.m
//  ListTests
//
//  Created by Jakub Skierbiszewski on 04/16/2015.
//  Copyright (c) 2015 Jakub Skierbiszewski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "ListTestDef.h"

// Testing quick start guide: https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/testing_with_xcode/testing_1_quick_start/testing_1_quick_start.html#//apple_ref/doc/uid/TP40014132-CH2-SW1
// Assertions: https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/testing_with_xcode/testing_3_writing_test_classes/testing_3_writing_test_classes.html#//apple_ref/doc/uid/TP40014132-CH4-SW34

@interface ListTests : XCTestCase

@end

@implementation ListTests {
    NSString* _str0;
    NSString* _str1;
    NSString* _str2;
}

- (void)setUp {
    [super setUp];
    _str0 = @"str0";
    _str1 = @"str1";
    _str2 = @"str2";
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddSize {
    id<List> list = [[ListImpl alloc] init];
    // Add objects
    XCTAssertEqual([list size], 0);
    XCTAssert([list add:_str0], @"Object added");
    XCTAssertEqual([list size], 1);
    
    XCTAssert([list add:_str1], @"Object added");
    XCTAssertEqual([list size], 2);
    
    XCTAssert([list add:_str2], @"Object added");
    XCTAssertEqual([list size], 3);
}

- (void) testGet {
    id<List> list = [[ListImpl alloc] init];
    [list add:_str0];
    [list add:_str1];
    [list add:_str2];
    XCTAssertEqualObjects([list get:0], _str0);
    XCTAssertEqualObjects([list get:1], _str1);
    XCTAssertEqualObjects([list get:2], _str2);
}

- (void) testGetBounds {
    id<List> list = [[ListImpl alloc] init];
    XCTAssertThrowsSpecificNamed([list get:0], NSException, NSRangeException);
    [list add:_str0];
    [list add:_str1];
    [list add:_str2];
    XCTAssertThrowsSpecificNamed([list get:4], NSException, NSRangeException);
}

@end
