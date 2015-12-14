//
//  NSDictionary+JPCategory.m
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import "NSDictionary+JPCategory.h"

@implementation NSDictionary (JPCategory)
- (id)safeObjectForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null]) {
		return nil;
	}
	return object;
}

- (void)setValue:(id)value forSafeKey:(NSString *)key
{
    NSAssert(key, @"key must not be nil");
    if (!key) {
        return;
    }
    [self setValue:value forKey:key];
}

@end

@implementation NSMutableDictionary (JPCategory)
- (void)setObject:(id)anObject forUndefinedKey:(id<NSCopying>)aKey
{
    NSAssert(aKey, @"Key must not be nil");
    if (!aKey) {
        return;
    }
    [self setObject:anObject forKey:aKey];
}
@end