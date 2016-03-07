//
//  NSString+Category.m
//  JPKit
//
//  Created by junpeng wang on 13-12-2.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import "NSString+Category.h"
#import "NSData-AES.h"
#include <CommonCrypto/CommonDigest.h>
@implementation NSString (Category)

- (NSString *)MD5Hash {
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];
}

+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
	return (__bridge NSString *)uuidStr ;
}

//AES
- (NSString *)AESEncryptWithPassphrase:(NSString *)pass
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data AESEncryptWithPassphrase:pass];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)AESDecryptWithPassphrase:(NSString *)pass
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data AESDecryptWithPassphrase:pass];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

//Validate
- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidatePhone{
	NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
	return [phoneTest evaluateWithObject:self];
}

// Adapted from http://snipplr.com/view/2771/compare-two-version-strings
- (NSComparisonResult)compareToVersionString:(NSString *)version {
	// Break version into fields (separated by '.')
	NSMutableArray *leftFields  = [[NSMutableArray alloc] initWithArray:[self  componentsSeparatedByString:@"."]];
	NSMutableArray *rightFields = [[NSMutableArray alloc] initWithArray:[version componentsSeparatedByString:@"."]];
	
	// Implict ".0" in case version doesn't have the same number of '.'
	if ([leftFields count] < [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[leftFields addObject:@"0"];
		}
	} else if ([leftFields count] > [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[rightFields addObject:@"0"];
		}
	}
	
	// Do a numeric comparison on each field
	for (NSUInteger i = 0; i < [leftFields count]; i++) {
		NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
		if (result != NSOrderedSame) {
			return result;
		}
	}
	
	return NSOrderedSame;
}


+ (id)stringWithInt:(int)value
{
    return [NSString stringWithFormat:@"%i",value];
}

+ (id)stringWithFloat:(float)value
{
    return [NSString stringWithFormat:@"%f",value];
}

+ (id)stringWithDouble:(double)value
{
    return [NSString stringWithFormat:@"%f",value];
}

+ (id)stringWithBool:(BOOL)value
{
    return [NSString stringWithFormat:@"%i",value];
}

+ (id)numberWithLong:(long)value
{
    return [NSString stringWithFormat:@"%li",value];
}

+ (id)numberWithLongLong:(long long)value
{
    return [NSString stringWithFormat:@"%lli",value];
}
@end
