//
//  ViewController.h
//  Unmineable-iOS
//
//  Created by Gabriel Betancourt on 9/17/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../iOSUtil/UtilColor.h"

@interface ViewController : UIViewController {
	float deviceWidth;
	float deviceHeight;
}

@property (weak, nonatomic) IBOutlet UIImageView *unmineableImageView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@end

