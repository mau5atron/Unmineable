//
//  UtilImage.h
//  Unmineable
//
//  Created by Gabriel on 10/15/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilImage : NSObject

+ (NSImage *)scaleImage:(NSImage *)image toSize:(NSSize)targetSize;

@end

NS_ASSUME_NONNULL_END
