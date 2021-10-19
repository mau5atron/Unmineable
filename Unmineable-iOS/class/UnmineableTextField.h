//
//  UnmineableTextField.h
//  Unmineable-iOS
//
//  Created by Gabriel on 10/15/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnmineableTextField : UITextField

- (CGRect)adjustedFrameToVerticallyCenterText:(CGRect)frame;
- (void)editWithFrame:(CGRect)rect inView:(UIView *)controlView editor:()textObj delegate:(id)delegate event:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END
