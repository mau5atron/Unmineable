//
//  ViewController.m
//  Unmineable-iOS
//
//  Created by Gabriel Betancourt on 9/17/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		NSLog(@"init with coder");
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.unLabel.textColor = [UtilColor colorFromHexString:@"#9CCABF"];
	self.mineableLabel.textColor = [UtilColor colorFromHexString:@"#4BCEB1"];
	
	deviceWidth = CGRectGetWidth(self.view.bounds);
	deviceHeight = CGRectGetHeight(self.view.bounds);
	CGFloat labelStackFrameOriginX = self.labelStack.frame.origin.x;
	CGFloat labelStackFrameOriginY = self.labelStack.frame.origin.y;
	CGFloat labelStackFrameBoundsWidth = self.labelStack.frame.size.width;
	CGFloat labelStackFrameBoundsHeight = self.labelStack.frame.size.height;
	
	self.labelStack.layer.frame = CGRectMake(labelStackFrameOriginX, labelStackFrameOriginY, labelStackFrameBoundsWidth, labelStackFrameBoundsHeight);
	NSLog(@"Screen Height: %.2f", self.view.bounds.size.height);
	[UIView animateWithDuration:1.0f delay:0.5f options:(UIViewAnimationOptions)UIViewAnimationOptionCurveEaseInOut animations:^{
		//NSLog(@"Animaating, labelStackFrameOriginY: %.2f", labelStackFrameOriginY);
		self.labelStack.layer.frame = CGRectMake(labelStackFrameOriginX, labelStackFrameOriginY - (self.view.bounds.size.height / 2) + 85, labelStackFrameBoundsWidth, labelStackFrameBoundsHeight);
	} completion:^(BOOL finished){
		//NSLog(@"Finished Animated label stack");
	}];
}


@end
