//
//  NSURL+JPCategory.m
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import "NSURL+JPCategory.h"

@implementation NSURL (JPCategory)

+ (id)URLWithFormat:(NSString *)format, ... {
	va_list arguments;
    va_start(arguments, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:arguments];
	va_end(arguments);
	
	return [NSURL URLWithString:string];
}

@end
