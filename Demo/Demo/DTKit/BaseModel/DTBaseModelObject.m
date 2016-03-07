//
//  DTBaseModelObject
//  FCHK_Iphone
//
//  Created by junpeng on 13-3-18.
//  Copyright (c) 2013年 FCHK Holdings Ltd. All rights reserved.
//

#import "DTBaseModelObject.h"
#import <objc/runtime.h>

@implementation DTBaseModelObject

+ (id)objectFromArchivedData:(NSData*)data
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (id)objectWithDataDic:(NSDictionary*)dataDic
{
    return [[[self class] alloc] initWithDataDic:dataDic];
}

-(id)initWithDataDic:(NSDictionary*)data{
	if (self = [super init]) {
		[self setAttributes:data];
	}
	return self;
}
-(NSDictionary*)attributeMapDictionary{
	return nil;
}

-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}
- (NSString *)customDescription{
	return nil;
}

- (NSString *)description{
	NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
	while ((attributeName = [keyEnum nextObject])) {
		id valueObj = [self valueForKey:attributeName];
        if (valueObj) {
            [attrsDesc appendFormat:@" \n       [%@ = %@]; ",attributeName,valueObj];
        }else {
            [attrsDesc appendFormat:@" \n       [%@ = nil]; ",attributeName];
        }
	}
	
	NSString *customDesc = [self customDescription];
	NSString *desc;
	
	if (customDesc && [customDesc length] > 0 ) {
		desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
	}else {
		desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
	}
	
	return desc;
}

-(void)setAttributes:(NSDictionary*)dataDic{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
        //DLog(@"key:  %@",attributeName);
		SEL sel = [self getSetterSelWithAttibuteName:attributeName];
		if ([self respondsToSelector:sel]) {
			NSString *dataDicKey = attrMapDic[attributeName];
            id value = nil;
            if ([dataDicKey isEqualToString:DUMP_KEY]) {
                continue;
            }
            if ([[dataDic objectForKey:dataDicKey] isKindOfClass:[NSNumber class]]) {
                value = [dataDic objectForKey:dataDicKey];
            }else if([[dataDic objectForKey:dataDicKey] isKindOfClass:[NSString class]]){
                value = [dataDic objectForKey:dataDicKey];
                NSString *type = [self getIvarTypeWithKey:attributeName];
                if ([type isEqualToString:@"c"]) {
                    value = [NSNumber numberWithChar:[value characterAtIndex:0]];
                }
                else if ([type isEqualToString:@"s"]) {
                    value = [NSNumber numberWithChar:[value characterAtIndex:0]];
                }
                else if ([type isEqualToString:@"i"]) {
                    value = [NSNumber numberWithInt:[value intValue]];
                }
                else if ([type isEqualToString:@"l"]) {
                    value = [NSNumber numberWithLong:[value intValue]];
                }
                else if ([type isEqualToString:@"ll"]) {
                    value = [NSNumber numberWithLongLong:[value intValue]];
                }
                else if ([type isEqualToString:@"f"]) {
                    value = [NSNumber numberWithFloat:[value floatValue]];
                }
                else if ([type isEqualToString:@"d"]) {
                    value = [NSNumber numberWithDouble:[value doubleValue]];
                }
                else{
                    
                }
                
            }else{
                value =  nil;
            }
            [self setValue:value forKey:attributeName];
            
		}
	}
}

- (id)initWithCoder:(NSCoder *)decoder{
	if( self = [super init] ){
		NSDictionary *attrMapDic = [self attributeMapDictionary];
		if (attrMapDic == nil) {
			return self;
		}
		NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
		id attributeName;
		while ((attributeName = [keyEnum nextObject])) {
            id obj = [decoder decodeObjectForKey:attributeName];
            [self setValue:obj forKey:attributeName];
		}
	}
	return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
        id valueObj = [self valueForKey:attributeName];
        if (valueObj) {
            [encoder encodeObject:valueObj forKey:attributeName];
        }
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    DTBaseModelObject *newClass = [[[self class] allocWithZone:zone] init];
    NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return newClass;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
        id value = [self valueForKey:attributeName];
        [newClass setValue:value forKey:attributeName];
    }
    
    return newClass;
}

- (NSData*)getArchivedData{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (NSString *)getIvarTypeWithKey:(NSString *)key
{
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList([self class], &numIvars);
    //Ivar *vars = class_copyIvarList([UIView class], &numIvars);
    
    NSString *_key=nil;
    NSString *type = nil;
    for(int i = 0; i < numIvars; i++) {
        
        Ivar thisIvar = vars[i];
        _key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        //NSLog(@"variable name :%@", _key);
        
        type = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        //NSLog(@"variable type :%@", type);
        if ([_key isEqualToString:key]||[_key isEqualToString:[@"_" stringByAppendingString:key]]) {
            break;
        }
    }
    free(vars);
    return type;
}

- (void)save
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *cachePath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",NSStringFromClass([self class])]];
    [NSKeyedArchiver archiveRootObject:self toFile:cachePath];
}

+ (id)read
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *cachePath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",NSStringFromClass([self class])]];
    //版本升级
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"KKVersionKey"];
    if(!oldVersion||![version isEqualToString:oldVersion]){
        //版本升级后删除缓存
        [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"KKVersionKey"];
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
}
@end
