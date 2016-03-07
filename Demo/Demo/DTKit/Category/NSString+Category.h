//
//  NSString+Category.h
//  JPKit
//
//  Created by junpeng wang on 13-12-2.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

- (NSString *)MD5Hash;
+ (NSString *)stringWithUUID;

//AES
- (NSString *)AESEncryptWithPassphrase:(NSString *)pass;
- (NSString *)AESDecryptWithPassphrase:(NSString *)pass;

- (BOOL)isValidateEmail;
- (BOOL)isValidatePhone;

///-------------------------
/// @name Comparing Versions
///-------------------------

/**
 Returns a comparison result for the receiver and a given `version`.
 
 Examples:
 
 <pre><code>[@"10.4" compareToVersionString:@"10.3"]; // NSOrderedDescending
 [@"10.5" compareToVersionString:@"10.5.0"]; // NSOrderedSame
 [@"10.4 Build 8L127" compareToVersionString:@"10.4 Build 8P135"]; // NSOrderedAscending</code></pre>
 
 @param version A version string to compare to the receiver
 
 @return A comparison result for the receiver and a given `version`
 */
- (NSComparisonResult)compareToVersionString:(NSString *)version;

+ (id)stringWithInt:(int)value;
+ (id)stringWithFloat:(float)value;
+ (id)stringWithDouble:(double)value;
+ (id)stringWithBool:(BOOL)value;

+ (id)numberWithLong:(long)value;
+ (id)numberWithLongLong:(long long)value;

@end
