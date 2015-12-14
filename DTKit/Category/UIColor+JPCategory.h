//
//  UIColor+JPCategory.h
//  JPKit
//
//  Created by junpeng wang on 13-12-4.
//  Copyright (c) 2013年 junpeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DTRGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define DTPureColor(p,a) [UIColor colorWithRed:p/255.0 green:p/255.0 blue:p/255.0 alpha:a]

@interface UIColor (JPCategory)
/**
 Creates and returns an UIColor object containing a given value.
 
 @param hex The value for the new color. The `#` sign is not required.
 
 @return An UIColor object containing a value.
 
 You can specify hex values in the following formats: `rgb`, `rrggbb`, or `rrggbbaa`.
 
 The default alpha value is `1.0`.
 
 */
+ (UIColor *)colorWithHex:(NSString *)hex;

/**
 Returns the receiver's value as a hex string.
 
 @return The receiver's value as a hex string.
 
 The value will be `nil` if the color is in a color space other than Grayscale or RGB. The `#` sign is omitted. Alpha
 will be omitted.
 */
- (NSString *)hexValue;

/**
 Returns the receiver's value as a hex string.
 
 @param includeAlpha `YES` if alpha should be included. `NO` if it should not.
 
 @return The receiver's value as a hex string.
 
 The value will be `nil` if the color is in a color space other than Grayscale or RGB. The `#` sign is omitted. Alpha is
 included if `includeAlpha` is `YES`.
 */
- (NSString *)hexValueWithAlpha:(BOOL)includeAlpha;

/**
 The receiver's red component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat red;

/**
 The receiver's green component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat green;

/**
 The receiver's blue component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat blue;

/**
 The receiver's alpha value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`, where `0.0` represents totally
 transparent and `1.0` represents totally opaque.
 */
@property (nonatomic, assign, readonly) CGFloat alpha;
@end
