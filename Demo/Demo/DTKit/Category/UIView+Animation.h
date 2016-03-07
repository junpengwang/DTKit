//
//  UIView+Animation.h
//  JPKit
//
//  Created by junpeng wang on 13-12-3.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
- (void)shake;

//截屏
- (UIImage *)imageRepresentation;

- (void)hide;
- (void)show;

- (void)fadeOut;
- (void)fadeOutAndRemoveFromSuperview;
- (void)fadeIn;

- (NSArray *)superviews;
- (id)firstSuperviewOfClass:(Class)superviewClass;
@end
