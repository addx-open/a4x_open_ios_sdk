//
//  UIColor+Extensions.m
//  A4xDeviceDemo_OC
//
//  Created by addx-wjin on 2022/2/17.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)colorWithHex:(long)hexColor {
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0f;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0f;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha{
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0f;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.0f;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF)) / 255.0f;
    return [UIColor colorWithRed:red green:green blue: blue alpha:alpha];
}

+ (UIColor *) colorWithHexString: (NSString *) hexString alpha:(CGFloat) alpha {
    
   hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
   hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
   NSRegularExpression *RegEx = [NSRegularExpression regularExpressionWithPattern:@"^[a-fA-F|0-9]{6}$" options:0 error:nil];
   NSUInteger match = [RegEx numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, hexString.length)];

   if (match == 0) {return [UIColor clearColor];}

   NSString *rString = [hexString substringWithRange:NSMakeRange(0, 2)];
   NSString *gString = [hexString substringWithRange:NSMakeRange(2, 2)];
   NSString *bString = [hexString substringWithRange:NSMakeRange(4, 2)];
   unsigned int r, g, b;
    
   BOOL rValue = [[NSScanner scannerWithString:rString] scanHexInt:&r];
   BOOL gValue = [[NSScanner scannerWithString:gString] scanHexInt:&g];
   BOOL bValue = [[NSScanner scannerWithString:bString] scanHexInt:&b];
   
   if (rValue && gValue && bValue) {
       return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
   } else {
       return [UIColor clearColor];
   }
}

@end
