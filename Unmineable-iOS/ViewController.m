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
	// Do any additional setup after loading the view.
	//self.unLabel.font = [[UIFont alloc] fontWithSize:200.0f];
//	self.unLabel.textColor = [UIColor whiteColor];
//	self.unLabel.font = [UIFont fontWithName:@"Poppins" size:400];
}


@end
