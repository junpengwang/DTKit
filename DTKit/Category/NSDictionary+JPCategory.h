//
//  NSDictionary+JPCategory.h
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JPCategory)
- (id)safeObjectForKey:(id)key;
@end

@interface NSMutableDictionary (JPCategory)
- (void)setObject:(id)anObject forUndefinedKey:(id<NSCopying>)aKey;
@end
