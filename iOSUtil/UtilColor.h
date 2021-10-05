//
//  UtilColor.h
//  Unmineable
//
//  Created by Gabriel on 9/28/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilColor : NSObject

+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
