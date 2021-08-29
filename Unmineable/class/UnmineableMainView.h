//
//  UnmineableMainView.h
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/28/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnmineableMainView : NSView

@property (weak, nonatomic) IBOutlet NSTextField *addressTextField;

- (void)mouseDown:(NSEvent *)event;

@end

NS_ASSUME_NONNULL_END
