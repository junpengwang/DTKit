//
//  UIImage+JPCategory.m
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import "UIImage+JPCategory.h"

@implementation UIImage (JPCategory)
- (UIImage *)imageCroppedToRect:(CGRect)rect {
	// CGImageCreateWithImageInRect's `rect` parameter is in pixels of the image's coordinates system. Convert from points.
	CGFloat scale = self.scale;
	rect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
	
	CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
	UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:scale orientation:self.imageOrientation];
	CGImageRelease(imageRef);
	return cropped;
}
@end
