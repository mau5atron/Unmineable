//
//  Color.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/16/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "UtilColor.h"

@implementation UtilColor

// Assumes input like "#00FF00" (#RRGGBB)
+ (NSColor *)colorFromHexString:(NSString *)hexString {
	unsigned rgbValue = 0;
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	[scanner setScanLocation:1]; // pass on the # character
	[scanner scanHexInt:&rgbValue];
	return [NSColor
					colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
					green:((rgbValue & 0xFF00) >> 8)/255.0
					blue:(rgbValue & 0xFF)/255.0
					alpha:1.0];
}

@end
