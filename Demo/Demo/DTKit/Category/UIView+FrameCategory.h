//
//  UIView+FrameCategory.h
//  JPKit
//
//  Created by junpeng wang on 13-12-2.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);
CGRect CGRectCenteredInRect(CGRect rect, CGRect mainRect);


@interface UIView (FrameCategory)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint midpoint;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;


@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

@end
