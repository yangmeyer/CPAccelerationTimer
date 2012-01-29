
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012 compeople. All rights reserved.

#import "CPViewController.h"
#import "CPAccelerationTimer.h"

@implementation CPViewController

@synthesize blinker;
@synthesize startBlinkingButton;

- (void) viewDidLoad {
	[super viewDidLoad];
}

- (void) viewDidUnload {
	[super viewDidUnload];
	self.blinker = nil;
	self.startBlinkingButton = nil;
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self startBlinking:nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}

- (IBAction) startBlinking:(id)sender {
	self.startBlinkingButton.alpha = 0.4;
	self.startBlinkingButton.enabled = NO;
	
	CPAccelerationTimerTick blink = ^(NSUInteger tickIndex) {
		self.blinker.alpha = 1.0;
		[UIView animateWithDuration:0.3 animations:^{
			self.blinker.alpha = 0.0;
		}];
	};
	CPAccelerationTimerCompletion reset = ^{
		self.blinker.alpha = 1.0;
		self.startBlinkingButton.hidden = NO;
		self.startBlinkingButton.alpha = 1.0;
		self.startBlinkingButton.enabled = YES;
	};
	[[CPAccelerationTimer accelerationTimerWithTicks:20
									   totalDuration:20.0
									   controlPoint1:CGPointMake(0.8, 0.0) // ease in
									   controlPoint2:CGPointMake(0.5, 1.0) // ease out
										atEachTickDo:blink
										  completion:reset]
	 run];
}

@end
