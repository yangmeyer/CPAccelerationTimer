
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012 compeople. All rights reserved.

#import <UIKit/UIKit.h>

@interface CPViewController : UIViewController

@property (nonatomic, assign) IBOutlet UIView* blinker;
@property (nonatomic, assign) IBOutlet UIButton* startBlinkingButton;

- (IBAction) startBlinking:(id)sender;

@end
