//
//  UIView+Animation.m
//  JPKit
//
//  Created by junpeng wang on 13-12-3.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
- (void)shake
{
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:2];
    [animation setRepeatCount:20];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self center].x - 10.0f, [self center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self center].x + 10.0f, [self center].y)]];
    [[self layer] addAnimation:animation forKey:@"position"];
}

- (UIImage *)imageRepresentation {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}


- (void)hide {
	self.alpha = 0.0f;
}


- (void)show {
	self.alpha = 1.0f;
}


- (void)fadeOut {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:nil];
}


- (void)fadeOutAndRemoveFromSuperview {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[view removeFromSuperview];
	}];
}


- (void)fadeIn {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 1.0f;
	} completion:nil];
}


- (NSArray *)superviews {
	NSMutableArray *superviews = [[NSMutableArray alloc] init];
	
	UIView *view = self;
	UIView *superview = nil;
	while (view) {
		superview = [view superview];
		if (!superview) {
			break;
		}
		
		[superviews addObject:superview];
		view = superview;
	}
	
	return superviews;
}

- (id)firstSuperviewOfClass:(Class)superviewClass {
	for (UIView *view = [self superview]; view != nil; view = [view superview]) {
		if ([view isKindOfClass:superviewClass]) {
			return view;
		}
	}
	return nil;
}
@end
