//
//  DTBaseModelObject
//  FCHK_Iphone
//
//  Created by junpeng on 13-3-18.
//  Copyright (c) 2013年 FCHK Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DUMP_KEY    @"DUMP_KEY"

@interface DTBaseModelObject : NSObject<NSCoding, NSCopying>

+ (id)objectFromArchivedData:(NSData*)data;
+ (id)objectWithDataDic:(NSDictionary*)dataDic;
- (id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

+ (id)read;
- (void)save;

@end
