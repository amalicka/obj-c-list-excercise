//
//  LinkedList.h
//  LinkedList
//
//  Created by Jakub Skierbiszewski on 04/16/2015.
//  Copyright (c) 2015 Jakub Skierbiszewski. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol List <NSObject>

/**
 * Adds object to the list.
 * @param object to add
 * @returns always true
 * @throws NSInvalidArgumentException if object is nil
 */
- (BOOL) add:(id)object;

/**
 * Inserts the specified object into this List at the specified location.
 * The object is inserted before the current element at the specified location.
 * If the location is equal to the size of this List, the object is added at the end.
 * If the location is smaller than the size of this List, then all elements beyond
 * the specified location are moved by one position towards the end of the List.
 * @param object to add
 * @param location where object should be added
 * @throws NSRangeException when locaiton > size()
 * @throws NSInvalidArgumentException if object is nil
 */
- (void) add:(id)object atLocation:(NSUInteger)location;

/**
 * Adds the objects in the specified collection to the end of this List.
 * The objects are added in the order in which they are returned from the collection's iterator.
 * @param objectList to be added to this list
 * @returns true if the List is modified, false otherwise (i.e. if the passed colleciton was empty)
 * @throws NSInvalidArgumentException if objectList is nil
 */
- (BOOL) addAll:(id<List>) objectList;

/**
 * Inserts the objects in the specified collection at the specified location in this List.
 * The objects are added in the order they are returned from the collection's iterator.
 * @param location the index at which to insert.
 * @param collection the collection of objects to be inserted.
 * @returns true if this List has been modified through the insertion, false otherwise (i.e. if the passed colleciton was empty)
 * @throws NSInvalidArgumentException if objectList is nil
 * @throws NSRangeException when location > size()
 */
- (BOOL) addAll:(id<List>) objectList atLocation:(NSUInteger) location;

/**
 * Returns the number of elements in this List.
 * @returns the number of elements in this List.
 */
- (NSUInteger) size;

/**
 * Returns whether this List contains no elements.
 * @returns true if this List has no elements, false otherwise.
 */
- (BOOL) isEmpty;

/**
 * Returns the element at the specified location in this List.
 * @param location the index of the element to return
 * @returns the element at the specified location
 * @throws NSRangeException when locaiton >= size()
 */
- (id) get:(NSUInteger) location;

/**
 * Replaces the element at the specified location in this List with the specified object.
 * This operation does not change the size of the List.
 * @param location the index at which to put the specified object.
 * @param object the object to insert.
 * @returns the previous element at the index
 * @throws NSRangeException when locaiton >= size()
 * @throws NSInvalidArgumentException if object is nil
 */
- (id) set:(id) object atLocation:(NSUInteger) location;

/**
 * Tests whether this List contains the specified object.
 * @param object the object to search for
 * @throws NSInvalidArgumentException if objectList is nil
 */
- (BOOL) contains:(id) object;

/**
 * Tests whether this List contains all objects contained by the specified collection.
 * @param objectList the collection of objects
 * @returns true if all objects in the specified collection are elements of this List, false otherwise.
 * @throws NSInvalidArgumentException if objectList is nil
 */
- (BOOL) containsAll:(id<List>) objectList;

/**
 * Searches this List for the specified object and returns the index of the first occurrence.
 * @param object the object to serarch for
 * @returns the location of the first occurence of the object or NSNotFound if the object was not found
 * @throws NSInvalidArgumentException if object is nil
 */
- (NSUInteger) locationOf:(id) object;

/**
 * Searches this List for the specified object and returns the index of the last occurrence.
 * @param object the object to search for
 * @returns the index of the last occurrence of the object, or -1 if the object was not found.
 * @throws NSInvalidArgumentException if object is nil
 */
- (NSUInteger) lastLocationOf:(id) object;

/**
 * Removes all elements from this List, leaving it empty.
 */
- (void) clear;

/**
 * Removes the first occurrence of the specified object from this List.
 * @param object the object to remove
 * @returns true if this List was modified by this operation, false otherwise.
 * @throws NSInvalidArgumentException if object is nil
 */
- (BOOL) remove:(id) object;

/**
 * Removes the object at the specified location from this List.
 * @param location the index of the object to remove.
 * @returns the removed object.
 * @throws NSRangeException when locaiton >= size()
 */
- (id) removeAtLocation:(NSUInteger) location;

/**
 * Removes all occurrences in this List of each object in the specified collection.
 * @param collection the collection of objects to remove.
 * @returns true if this List is modified, false otherwise.
 * @throws NSInvalidArgumentException if objectList is nil
 */
- (BOOL) removeAll:(id<List>) objectList;

/**
 * Removes all objects from this List that are not contained in the specified collection.
 * @param collection the collection of objects to retain.
 * @returns true if this List is modified, false otherwise.
 * @throws NSInvalidArgumentException if objectList is nil
 */
- (BOOL) retainAll:(id<List>) objectList;

/**
 * Returns a List of the specified portion of this List from the given start index to 
 * the end index minus one. The returned List is backed by this List 
 * so changes to it are reflected by the other.
 * @param startLocation the index at which to start the sublist.
 * @param endLocation the index one past the end of the sublist.
 * @returns
 * @throws NSRangeException when startLocation >= size() or endLocation >= size()
 */
- (id<List>) subListFromLocation:(NSUInteger) startLocation toLocation:(NSUInteger) endLocation;

/**
 * Returns an array containing all elements contained in this List.
 */
- (NSArray*) toArray;

/**
 * Returns true if other is a List containing same elements (by equals method of those elements) 
 * @see http://nshipster.com/equality/
 */
- (BOOL) isEqual:(id) other;

/** 
 * Returns hash code of this List
 * @see http://stackoverflow.com/questions/254281/best-practices-for-overriding-isequal-and-hash
 */
- (NSUInteger) hash;

@end