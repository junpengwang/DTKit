//
//  NSArray+JPCategory.h
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JPCategory)

- (id)safeObjectAtIndex:(NSInteger)index;

@end


@interface NSMutableArray (safe)
- (void)insertObject:(id)anObject atUndefinedIndex:(NSUInteger)index;
@end