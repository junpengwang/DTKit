//
//  NSArray+JPCategory.m
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import "NSArray+JPCategory.h"

@implementation NSArray (JPCategory)
- (id)safeObjectAtIndex:(NSInteger)index
{
    NSAssert(index>=0&&index<[self count], @"array index error");
    if (index<0&&index>=[self count]) {
        return nil;
    }
	id object = [self objectAtIndex:index];
	if (object == [NSNull null]) {
		return nil;
	}
	return object;
}
@end

@implementation NSMutableArray (safe)
- (void)insertObject:(id)anObject atUndefinedIndex:(NSUInteger)index
{
    NSAssert(index<[self count], @"array index error");
    if (index>=[self count]) {
        return;
    }
	[self insertObject:anObject atIndex:index];
}
@end