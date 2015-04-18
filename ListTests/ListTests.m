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
    
    id<List> _list;
}

- (void)setUp {
    [super setUp];
    _str0 = @"str0";
    _str1 = @"str1";
    _str2 = @"str2";
    _list = [[ListImpl alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testAddNil {
    XCTAssertThrowsSpecificNamed([_list add:nil], NSException, NSInvalidArgumentException);
}

- (void)testAddSize {
    XCTAssertEqual([_list size], 0);
    XCTAssert([_list add:_str0], @"Object added");
    XCTAssertEqual([_list size], 1);
    
    XCTAssert([_list add:_str1], @"Object added");
    XCTAssertEqual([_list size], 2);
    
    XCTAssert([_list add:_str2], @"Object added");
    XCTAssertEqual([_list size], 3);
}

- (void) testGet {
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str2];
    [_list add:_str1];
    [_list add:_str1];
    XCTAssertEqualObjects([_list get:0], _str0);
    XCTAssertEqualObjects([_list get:1], _str1);
    XCTAssertEqualObjects([_list get:2], _str2);
    XCTAssertEqualObjects([_list get:3], _str1);
    XCTAssertEqualObjects([_list get:4], _str1);
}

- (void) testGetBounds {
    XCTAssertThrowsSpecificNamed([_list get:0], NSException, NSRangeException);
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str2];
    XCTAssertThrowsSpecificNamed([_list get:3], NSException, NSRangeException);
}

- (void) testIsEmpty {
    XCTAssert([_list isEmpty]);
    [_list add:_str1];
    XCTAssertFalse([_list isEmpty]);
}

- (void) testContains {
    [_list add:_str0];
    [_list add:_str2];
    [_list add:_str2];
    XCTAssertThrowsSpecificNamed([_list contains:nil], NSException, NSInvalidArgumentException);
    XCTAssert([_list contains:_str0]);
    XCTAssert([_list contains:_str2]);
    XCTAssertFalse([_list contains:_str1]);
    
    NSString* copyCheck = [[NSString alloc] initWithString:_str2];
    XCTAssert([_list contains:copyCheck]);
}

- (void) testContainsAll {
    [_list add:_str0];
    [_list add:_str1];
    
    XCTAssertThrowsSpecificNamed([_list containsAll:nil], NSException, NSInvalidArgumentException);
    
    id<List> listSame = [[ListImpl alloc] init];
    [listSame add:_str0];
    [listSame add:_str1];
    XCTAssert([_list containsAll:listSame]);
    
    id<List> listEmpty = [[ListImpl alloc] init];
    XCTAssert([_list containsAll:listEmpty]);
    
    id<List> listDifferentSmall = [[ListImpl alloc] init];
    [listDifferentSmall add:_str2];
    XCTAssertFalse([_list containsAll:listDifferentSmall]);
    
    id<List> listDifferentBig = [[ListImpl alloc] init];
    [listDifferentBig add:_str0];
    [listDifferentBig add:_str1];
    [listDifferentBig add:_str2];
    XCTAssertFalse([_list containsAll:listDifferentBig]);
}

- (void) testLocationOf {
    [_list add:_str2];
    [_list add:_str0];
    [_list add:_str1];
    
    XCTAssertThrowsSpecificNamed([_list locationOf:nil], NSException, NSInvalidArgumentException);
    XCTAssertEqual(0, [_list locationOf:_str2]);
    XCTAssertEqual(1, [_list locationOf:_str0]);
    XCTAssertEqual(2, [_list locationOf:_str1]);
    
    NSString *other = @"Some non-existent string";
    XCTAssertEqual(NSNotFound, [_list locationOf:other]);
    
    NSString *copy = [[NSString alloc] initWithString:_str0];
    XCTAssertEqual(1, [_list locationOf:copy]);
}

- (void) testLastLocationOf {
    [_list add:_str2];
    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str2];
    [_list add:_str2];
    [_list add:_str1];
    
    NSString *other = @"Some non-existent string";
    XCTAssertThrowsSpecificNamed([_list lastLocationOf:nil], NSException, NSInvalidArgumentException);
    XCTAssertEqual(2, [_list lastLocationOf:_str0]);
    XCTAssertEqual(4, [_list lastLocationOf:_str2]);
    XCTAssertEqual(5, [_list lastLocationOf:_str1]);
    XCTAssertEqual(NSNotFound, [_list lastLocationOf:other]);
}

- (void) testAddAtLocation {
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str1];
    
    // Add after the end
    XCTAssertThrowsSpecificNamed([_list add:nil atLocation:0], NSException, NSInvalidArgumentException);
    XCTAssertThrowsSpecificNamed([_list add:_str2 atLocation:7], NSException, NSRangeException);
    XCTAssertEqualObjects(_str0, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    XCTAssertEqualObjects(_str0, [_list get:2]);
    XCTAssertEqualObjects(_str1, [_list get:3]);
    XCTAssertEqualObjects(_str0, [_list get:4]);
    XCTAssertEqualObjects(_str1, [_list get:5]);
    
    // Add in the middle
    [_list add:_str2 atLocation: 2];
    XCTAssertEqual(7, [_list size]);
    XCTAssertEqualObjects(_str0, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    XCTAssertEqualObjects(_str2, [_list get:2]);
    XCTAssertEqualObjects(_str0, [_list get:3]);
    XCTAssertEqualObjects(_str1, [_list get:4]);
    XCTAssertEqualObjects(_str0, [_list get:5]);
    XCTAssertEqualObjects(_str1, [_list get:6]);
    
    // Add at the end
    [_list add:_str2 atLocation: 7];
    XCTAssertEqual(8, [_list size]);
    XCTAssertEqualObjects(_str0, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    XCTAssertEqualObjects(_str2, [_list get:2]);
    XCTAssertEqualObjects(_str0, [_list get:3]);
    XCTAssertEqualObjects(_str1, [_list get:4]);
    XCTAssertEqualObjects(_str0, [_list get:5]);
    XCTAssertEqualObjects(_str1, [_list get:6]);
    XCTAssertEqualObjects(_str2, [_list get:7]);
    
    // Add at the beginning
    [_list add:_str2 atLocation:0];
    XCTAssertEqual(9, [_list size]);
    XCTAssertEqualObjects(_str2, [_list get:0]);
    XCTAssertEqualObjects(_str0, [_list get:1]);
    XCTAssertEqualObjects(_str1, [_list get:2]);
    XCTAssertEqualObjects(_str2, [_list get:3]);
    XCTAssertEqualObjects(_str0, [_list get:4]);
    XCTAssertEqualObjects(_str1, [_list get:5]);
    XCTAssertEqualObjects(_str0, [_list get:6]);
    XCTAssertEqualObjects(_str1, [_list get:5]);
    XCTAssertEqualObjects(_str2, [_list get:8]);
}

- (void) testAddAll {
    XCTAssertThrowsSpecificNamed([_list addAll:nil], NSException, NSInvalidArgumentException);
    id<List> emptyList = [[ListImpl alloc] init];
    XCTAssertFalse([_list addAll:emptyList]);
    XCTAssertEqual(0, [_list size]);
    
    id<List> listWithElements = [[ListImpl alloc] init];
    [listWithElements add:_str1];
    [listWithElements add:_str1];
    
    XCTAssertTrue([_list addAll:listWithElements]);
    XCTAssertEqual(2, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    
    [_list add:_str0];
    [_list add:_str0];
    [_list add:_str0];
    XCTAssertTrue([_list addAll:listWithElements]);
    XCTAssertEqual(7, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    XCTAssertEqualObjects(_str0, [_list get:2]);
    XCTAssertEqualObjects(_str0, [_list get:3]);
    XCTAssertEqualObjects(_str0, [_list get:4]);
    XCTAssertEqualObjects(_str1, [_list get:5]);
    XCTAssertEqualObjects(_str1, [_list get:6]);
}

- (void) testAddAllAtLocation {
    // nil situation
    XCTAssertThrowsSpecificNamed([_list addAll:nil atLocation:0], NSException, NSInvalidArgumentException);
    XCTAssertEqual(0, [_list size]);
    XCTAssertThrowsSpecificNamed([_list addAll:nil atLocation:1], NSException, NSInvalidArgumentException);
    XCTAssertEqual(0, [_list size]);
    
    // Add empty
    id<List> emptyList = [[ListImpl alloc] init];
    XCTAssertFalse([_list addAll:emptyList atLocation:0]);
    XCTAssertThrowsSpecificNamed([_list addAll:emptyList atLocation:1], NSException, NSRangeException);
    XCTAssertEqual(0, [_list size]);
    
    // Add at the begining, empty target
    id<List> listWithElements = [[ListImpl alloc] init];
    [listWithElements add:_str1];
    [listWithElements add:_str1];
    XCTAssertThrowsSpecificNamed([_list addAll:listWithElements atLocation:1], NSException, NSRangeException);
    XCTAssertEqual(0, [_list size]);
    XCTAssertTrue([_list addAll:listWithElements atLocation:0]);
    XCTAssertEqual(2, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    
    // Add in the middle
    id<List> otherListWithElements = [[ListImpl alloc] init];
    [otherListWithElements add:_str2];
    [otherListWithElements add:_str2];
    [otherListWithElements add:_str2];
    XCTAssertThrowsSpecificNamed([_list addAll:otherListWithElements atLocation:3], NSException, NSRangeException);
    XCTAssertTrue([_list addAll:otherListWithElements atLocation:1]);
    XCTAssertEqual(5, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str2, [_list get:1]);
    XCTAssertEqualObjects(_str2, [_list get:2]);
    XCTAssertEqualObjects(_str2, [_list get:3]);
    XCTAssertEqualObjects(_str1, [_list get:4]);

    // Add at the end
    XCTAssertTrue([_list addAll:listWithElements atLocation:5]);
    XCTAssertEqual(7, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str2, [_list get:1]);
    XCTAssertEqualObjects(_str2, [_list get:2]);
    XCTAssertEqualObjects(_str2, [_list get:3]);
    XCTAssertEqualObjects(_str1, [_list get:4]);
    XCTAssertEqualObjects(_str1, [_list get:5]);
    XCTAssertEqualObjects(_str1, [_list get:6]);
    
    // Add at the beginning, populated target
    XCTAssertTrue([_list addAll:otherListWithElements atLocation:0]);
    XCTAssertEqual(10, [_list size]);
    XCTAssertEqualObjects(_str2, [_list get:0]);
    XCTAssertEqualObjects(_str2, [_list get:1]);
    XCTAssertEqualObjects(_str2, [_list get:2]);
    XCTAssertEqualObjects(_str1, [_list get:3]);
    XCTAssertEqualObjects(_str2, [_list get:4]);
    XCTAssertEqualObjects(_str2, [_list get:5]);
    XCTAssertEqualObjects(_str2, [_list get:6]);
    XCTAssertEqualObjects(_str1, [_list get:7]);
    XCTAssertEqualObjects(_str1, [_list get:8]);
    XCTAssertEqualObjects(_str1, [_list get:9]);
}

- (void) testClear {
    [_list clear];
    XCTAssertTrue([_list isEmpty]);
    XCTAssertEqual(0, [_list size]);
    [_list add:_str2];
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str1];
    [_list add:_str0];
    XCTAssertEqual(5, [_list size]);
    [_list clear];
    XCTAssertTrue([_list isEmpty]);
    XCTAssertEqual(0, [_list size]);
}

- (void) testRemove {
    XCTAssertThrowsSpecificNamed([_list remove:nil], NSException, NSInvalidArgumentException);
    XCTAssertFalse([_list remove:_str0]);
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str2];
    [_list add:_str1];
    [_list add:_str0];
    XCTAssertThrowsSpecificNamed([_list remove:nil], NSException, NSInvalidArgumentException);
    XCTAssertFalse([_list remove:@"Other"]);
    XCTAssertEqual(5, [_list size]);
    
    // Test remove object, same instance
    XCTAssertTrue([_list remove:_str0]);
    XCTAssertEqual(4, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str2, [_list get:1]);
    XCTAssertEqualObjects(_str1, [_list get:2]);
    XCTAssertEqualObjects(_str0, [_list get:3]);
    
    // Remove using copy of object (isEqual true, but no the same instance)
    XCTAssertTrue([_list remove:[[NSString alloc] initWithString:_str2]]);
    XCTAssertEqual(3, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    XCTAssertEqualObjects(_str0, [_list get:2]);
    
    XCTAssertTrue([_list remove:_str1]);
    XCTAssertEqual(2, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str0, [_list get:1]);
    
    XCTAssertTrue([_list remove:_str0]);
    XCTAssertEqual(1, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    
    XCTAssertTrue([_list remove:_str1]);
    XCTAssertEqual(0, [_list size]);
    XCTAssertTrue([_list isEmpty]);
}

- (void) testRemoveAtLocation {
    XCTAssertThrowsSpecificNamed([_list removeAtLocation:0], NSException, NSRangeException);
    [_list add:_str2];
    [_list add:_str2];
    [_list add:_str0];
    [_list add:_str1];
    XCTAssertThrowsSpecificNamed([_list removeAtLocation:4], NSException, NSRangeException);
    
    XCTAssertEqualObjects(_str0, [_list removeAtLocation:2]);
    XCTAssertEqual(3, [_list size]);
    XCTAssertEqualObjects(_str2, [_list get:0]);
    XCTAssertEqualObjects(_str2, [_list get:1]);
    XCTAssertEqualObjects(_str1, [_list get:2]);
    
    XCTAssertEqualObjects(_str2, [_list removeAtLocation:0]);
    XCTAssertEqual(2, [_list size]);
    XCTAssertEqualObjects(_str2, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    
    XCTAssertEqualObjects(_str1, [_list removeAtLocation:1]);
    XCTAssertEqual(1, [_list size]);
    XCTAssertEqualObjects(_str2, [_list get:0]);
    
    XCTAssertEqualObjects(_str2, [_list removeAtLocation:0]);
    XCTAssertEqual(0, [_list size]);
    XCTAssertTrue([_list isEmpty]);
}

- (void) testRemoveAll {
    XCTAssertThrowsSpecificNamed([_list removeAll:nil], NSException, NSInvalidArgumentException);
    id<List> emptyList = [[ListImpl alloc] init];
    XCTAssertFalse([_list removeAll:emptyList]);
    
    id<List> otherList = [[ListImpl alloc] init];
    [otherList add:@"Other object"];
    [otherList add:@"another other object"];
    XCTAssertFalse([_list removeAll:emptyList]);
    
    [_list add:_str0];
    [_list add:_str0];
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str1];
    XCTAssertFalse([_list removeAll:otherList], @"No objects should be removed");
    XCTAssertEqual(5, [_list size], @"No objects were removed");
    
    id<List> smallList = [[ListImpl alloc] init];
    [smallList add:_str0];
    [smallList add:_str0];
    XCTAssertTrue([_list removeAll:smallList]);
    XCTAssertEqual(2, [_list size]);
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    
    id<List> bigList = [[ListImpl alloc] init];
    [bigList add:_str1];
    [bigList add:_str1];
    [bigList add:_str2];
    [bigList add:_str2];
    [bigList add:_str2];
    XCTAssertTrue([_list removeAll:bigList]);
    XCTAssertEqual(0, [_list size]);
    XCTAssertTrue([_list isEmpty]);
    
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str2];
    [_list add:_str2];
    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str1];
    XCTAssertTrue([_list removeAll:bigList]);
    XCTAssertEqual(2, [_list size]);
    XCTAssertEqualObjects(_str0, [_list get:0]);
    XCTAssertEqualObjects(_str0, [_list get:1]);
}

- (void) testRetainAll {
    XCTAssertThrowsSpecificNamed([_list retainAll:nil], NSException, NSInvalidArgumentException);
    
    id<List> emptyList = [[ListImpl alloc] init];
    XCTAssertFalse([_list retainAll:emptyList]);
    
    id<List> otherList = [[ListImpl alloc] init];
    [otherList add:@"Other object"];
    [otherList add:@"another other object"];
    [_list add:_str0];
    [_list add:_str0];
    XCTAssertTrue([_list retainAll:emptyList], @"All emements should be removed");
    XCTAssertTrue([_list isEmpty], @"All elements are removed");
    
    [_list add:_str0];
    [_list add:_str0];
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str1];
    
    id<List> smallList = [[ListImpl alloc] init];
    [smallList add:_str0];
    [smallList add:_str0];
    XCTAssertTrue([_list retainAll:smallList]);
    XCTAssertEqual(3, [_list size]);
    XCTAssertEqualObjects(_str0, [_list get:0]);
    XCTAssertEqualObjects(_str0, [_list get:1]);
    XCTAssertEqualObjects(_str0, [_list get:2]);
    
    [_list add:_str2];
    [_list add:_str2];
    
    id<List> bigList = [[ListImpl alloc] init];
    [bigList add:_str1];
    [bigList add:_str1];
    [bigList add:_str2];
    [bigList add:_str2];
    [bigList add:_str2];
    XCTAssertTrue([_list retainAll:bigList]);
    XCTAssertEqual(2, [_list size]);
    XCTAssertEqualObjects(_str2, [_list get:0]);
    XCTAssertEqualObjects(_str2, [_list get:1]);
    
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str2];
    [_list add:_str2];
    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str1];
    XCTAssertTrue([_list retainAll:bigList]);
    XCTAssertEqual(7, [_list size]);
    XCTAssertEqualObjects(_str2, [_list get:0]);
    XCTAssertEqualObjects(_str2, [_list get:1]);
    XCTAssertEqualObjects(_str1, [_list get:2]);
    XCTAssertEqualObjects(_str2, [_list get:3]);
    XCTAssertEqualObjects(_str2, [_list get:4]);
    XCTAssertEqualObjects(_str1, [_list get:5]);
    XCTAssertEqualObjects(_str1, [_list get:6]);
}

- (void) testIsEqual {
    [_list add:_str0];
    [_list add:_str0];
    [_list add:_str2];
    
    id<List> empty = [[ListImpl alloc] init];
    id<List> secondEmpty = [[ListImpl alloc] init];
    XCTAssertTrue([empty isEqual: secondEmpty]);
    XCTAssertFalse([empty isEqual:nil]);
    XCTAssertFalse([_list isEqual:empty]);
    XCTAssertFalse([empty isEqual:_list]);
    
    id<List> notSame = [[ListImpl alloc] init];
    [notSame add:_str1];
    [notSame add:_str0];
    XCTAssertFalse([_list isEqual:notSame]);
    XCTAssertFalse([notSame isEqual:_list]);
    
    id<List> orderChanged = [[ListImpl alloc] init];
    [orderChanged add:_str0];
    [orderChanged add:_str2];
    [orderChanged add:_str0];
    XCTAssertFalse([_list isEqual:orderChanged]);
    XCTAssertFalse([orderChanged isEqual:_list]);
    
    id<List> same = [[ListImpl alloc] init];
    [same add:_str0];
    [same add:_str0];
    [same add:_str2];
    XCTAssertTrue([_list isEqual:same]);
    XCTAssertTrue([same isEqual:_list]);
}

- (void) testToArray {
    NSArray *empty = [[NSArray alloc] init];
    XCTAssertEqualObjects(empty, [_list toArray]);
    
    [_list add:_str0];
    NSArray *oneElement = [[NSArray alloc] initWithObjects:_str0, nil];
    XCTAssertEqualObjects(oneElement, [_list toArray]);
    
    [_list add:_str2];
    [_list add:_str0];
    [_list add:_str1];
    NSArray *multielem = [[NSArray alloc] initWithObjects:_str0, _str2, _str0, _str1, nil];
    XCTAssertEqualObjects(multielem, [_list toArray]);
    
    [_list remove:_str2];
    [_list removeAtLocation:1];
    NSArray *afterDelete = [[NSArray alloc] initWithObjects:_str0, _str1, nil];
    XCTAssertEqualObjects(afterDelete, [_list toArray]);
}

- (void) testHash {
    id<List> equalList = [[ListImpl alloc] init];
    XCTAssertEqual([_list hash], [equalList hash], @"Empty lists return same hash");
    
    [_list add:_str1];
    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str2];
    [_list add:_str2];
    
    [equalList add:_str1];
    [equalList add:_str1];
    [equalList add:_str0];
    [equalList add:_str2];
    [equalList add:_str2];
    XCTAssertEqual([_list hash], [equalList hash], @"Lists with same elements return same hash");
    
    id<List> diffList = [[ListImpl alloc] init];
    [diffList add:_str1];
    [diffList add:_str1];
    [diffList add:_str1];
    [diffList add:_str2];
    [diffList add:_str2];
    XCTAssertNotEqual([_list hash], [diffList hash], @"Lists with different elements return different hash");
}

- (void) testSetAtLocation {
    XCTAssertThrowsSpecificNamed([_list set:nil atLocation:0], NSException, NSInvalidArgumentException);
    XCTAssertEqual(0, [_list size], @"Size not changed by set");
    XCTAssertThrowsSpecificNamed([_list set:_str0 atLocation:0], NSException, NSRangeException);
    XCTAssertEqual(0, [_list size], @"Size not changed by set");
    [_list add:_str2];
    XCTAssertEqualObjects(_str2, [_list set:_str1 atLocation:0], @"Returned old element");
    XCTAssertEqualObjects(_str1, [_list get:0], @"New element was inserted");
    XCTAssertEqual(1, [_list size], @"Size not changed by set");

    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str0];
    
    XCTAssertEqualObjects(_str0, [_list set:_str1 atLocation:2], @"Returned old element");
    XCTAssertEqual(4, [_list size], @"Size not changed by set");
    XCTAssertEqualObjects(_str0, [_list set:_str1 atLocation:3], @"Returned old element");
    XCTAssertEqual(4, [_list size], @"Size not changed by set");
    XCTAssertThrowsSpecificNamed([_list set:_str1 atLocation:4], NSException, NSRangeException);
    XCTAssertEqual(4, [_list size], @"Size not changed by set");
    
    XCTAssertEqualObjects(_str1, [_list get:0]);
    XCTAssertEqualObjects(_str1, [_list get:1]);
    XCTAssertEqualObjects(_str1, [_list get:2]);
    XCTAssertEqualObjects(_str1, [_list get:3]);
}

- (void) testSubList {
    XCTAssertThrowsSpecificNamed([_list subListFromLocation:0 toLocation:0], NSException, NSRangeException);
    [_list add:_str0];
    XCTAssertThrowsSpecificNamed([_list subListFromLocation:1 toLocation:1], NSException, NSRangeException);
    XCTAssertThrowsSpecificNamed([_list subListFromLocation:1 toLocation:0], NSException, NSRangeException);
    
    id<List> returned = [_list subListFromLocation:0 toLocation:1];
    XCTAssertEqual(1, [returned size]);
    XCTAssertEqual(_str0, [returned get:0]);
    
    [_list add:_str2];
    [_list add:_str0];
    [_list add:_str1];
    [_list add:_str1];
    [_list add:_str0];
    [_list add:_str2];
    
    XCTAssertThrowsSpecificNamed([_list subListFromLocation:7 toLocation:0], NSException, NSRangeException);
    XCTAssertThrowsSpecificNamed([_list subListFromLocation:0 toLocation:8], NSException, NSRangeException);
    XCTAssertThrowsSpecificNamed([_list subListFromLocation:7 toLocation:8], NSException, NSRangeException);
    
    returned = [_list subListFromLocation:0 toLocation:7];
    XCTAssertEqualObjects(returned, _list);
    
    returned = [_list subListFromLocation:6 toLocation:7];
    XCTAssertEqual(1, [returned size]);
    XCTAssertEqualObjects(_str2, [returned get:0]);
    
    returned = [_list subListFromLocation:4 toLocation:6];
    XCTAssertEqual(2, [returned size]);
    XCTAssertEqual(_str1, [returned get:0]);
    XCTAssertEqual(_str0, [returned get:1]);
}

@end
