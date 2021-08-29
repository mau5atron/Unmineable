//
//  UnmineableTextFieldCell.h
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/21/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnmineableTextFieldCell : NSTextFieldCell

@property (nonatomic) CGFloat horizontalShift;

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame;

- (void)editWithFrame:(NSRect)rect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)delegate event:(NSEvent *)event;

- (void)setHorizontalShift:(CGFloat)horizontalShift;
@end

NS_ASSUME_NONNULL_END
