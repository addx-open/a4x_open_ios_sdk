//
//  UIColor+Extensions.h
//  A4xDeviceDemo_OC
//
//  Created by addx-wjin on 2022/2/17.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)colorWithHex: (long)hexColor;

+ (UIColor *)colorWithHex: (long)hexColor alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString: (NSString *) hexString alpha:(CGFloat)alpha;

@end
