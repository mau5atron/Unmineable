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
	//self.unLabel.textColor = [UtilColor colorFromHexString:@"#9CCABF"];
	//self.mineableLabel.textColor = [UtilColor colorFromHexString:@"#4BCEB1"];
	
	deviceWidth = CGRectGetWidth(self.view.bounds);
	deviceHeight = CGRectGetHeight(self.view.bounds);
	CGFloat labelStackFrameOriginX = self.unmineableImageView.frame.origin.x;
	CGFloat labelStackFrameOriginY = self.unmineableImageView.frame.origin.y;
	CGFloat labelStackFrameBoundsWidth = self.unmineableImageView.frame.size.width;
	CGFloat labelStackFrameBoundsHeight = self.unmineableImageView.frame.size.height;
	NSUInteger unmineableImageViewCenterYToSuperview = 90; // vertical alignment for imageview
	
	//self.labelStack.layer.frame = CGRectMake(labelStackFrameOriginX, labelStackFrameOriginY, labelStackFrameBoundsWidth, labelStackFrameBoundsHeight);
	self.unmineableImageView.layer.frame = CGRectMake(labelStackFrameOriginX, labelStackFrameOriginY, labelStackFrameBoundsWidth, labelStackFrameBoundsHeight);
	//NSLog(@"Screen Height: %.2f", self.view.bounds.size.height);
	[UIView animateWithDuration:1.0f delay:0.5f options:(UIViewAnimationOptions)UIViewAnimationOptionCurveEaseInOut animations:^{
		//NSLog(@"Animaating, labelStackFrameOriginY: %.2f", labelStackFrameOriginY);
		
		//this should be the image
		//self.labelStack.layer.frame = CGRectMake(labelStackFrameOriginX, labelStackFrameOriginY - (self.view.bounds.size.height / 2) + 85, labelStackFrameBoundsWidth, labelStackFrameBoundsHeight);
		self.unmineableImageView.layer.frame = CGRectMake(labelStackFrameOriginX, labelStackFrameOriginY - (self.view.bounds.size.height / 2) + unmineableImageViewCenterYToSuperview, labelStackFrameBoundsWidth, labelStackFrameBoundsHeight);
	} completion:^(BOOL finished){
		// unhide textfield
		self.searchTextField.hidden = FALSE;
		// CATransform3D perspective = CATransform3DIdentity;
		// perspective.m34 = -1.0 / 500;
		
		// self.unmineableImageView.layer.sublayerTransform = perspective;
		
		CATransform3D transform = CATransform3DMakeRotation(M_1_PI, 0, 1, 0);
		self.unmineableImageView.layer.transform = transform;
	}];
}

@end
