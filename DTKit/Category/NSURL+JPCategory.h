//
//  NSURL+JPCategory.h
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (JPCategory)
+ (id)URLWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
@end
