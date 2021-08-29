//
//  UtilColor.h
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/16/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#ifndef Util_Color_h
#define Util_Color_h

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "../Util.h"

@interface UtilColor : Util

+ (NSColor *)colorFromHexString:(NSString *)hexString;

@end


#endif /* Util_Color_h */
