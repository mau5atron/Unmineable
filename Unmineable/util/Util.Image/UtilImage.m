//
//  UtilImage.m
//  Unmineable
//
//  Created by Gabriel on 10/15/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "UtilImage.h"

@implementation UtilImage

+ (NSImage *)scaleImage:(NSImage *)image toSize:(NSSize)targetSize {
	NSImage *newScaledImage = [[NSImage alloc] initWithSize:targetSize];

	@try {
		if (image){
			NSSize imageSize = [image size];
			float imageWidth = imageSize.width;
			float imageHeight = imageSize.height;
			float targetWidth = targetSize.width;
			float targetHeight = targetSize.height;
			float scaleFactor = 0.0;
			float scaledWidth = targetWidth;
			float scaledHeight = targetHeight;
			
			NSPoint pngPoint = NSZeroPoint;
			
			if ( !NSEqualSizes(imageSize, targetSize) ){
				float widthFactor = targetWidth / imageWidth;
				float heightFactor = targetHeight / imageHeight;
				
				if ( widthFactor < heightFactor ){
					scaleFactor = widthFactor;
				} else {
					scaleFactor = heightFactor;
				}
				
				scaledWidth = imageWidth * scaleFactor;
				scaledHeight = imageHeight * scaleFactor;
				
				if ( widthFactor < heightFactor ){
					pngPoint.y = (targetHeight - scaledHeight) * 0.5;
				} else if ( widthFactor > heightFactor ){
					pngPoint.x = (targetWidth - scaledWidth) * 0.5;
				}
				
				// NSImage *newScaledImage = [[NSImage alloc] initWithSize:targetSize];
				[newScaledImage lockFocus];
				
				NSRect pngRect;
				pngRect.origin = pngPoint;
				pngRect.size.width = scaledWidth;
				pngRect.size.height = scaledHeight;
				
				[image drawInRect:pngRect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0];
				
				[newScaledImage unlockFocus];
			}
			
		}

		return newScaledImage;
	} @catch (NSException *exception) {
		NSLog(@"***Error scaling image: %@", exception);
		return newScaledImage;
	}
}
@end
