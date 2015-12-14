//
//  UIDevice+JPCategory.m
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import "UIDevice+JPCategory.h"

@implementation UIDevice (JPCategory)

+ (BOOL)isIOS7
{
    return __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0;
}

+ (BOOL)isIphone5
{
    return ([[UIScreen mainScreen] bounds].size.height == 568);
}

+ (BOOL)isSimulator {
	static NSString *simulatorModel = @"iPhone Simulator";
	return [[[UIDevice currentDevice] model] isEqualToString:simulatorModel];
}
@end
