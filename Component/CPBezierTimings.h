
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012 compeople. All rights reserved.

#import <Foundation/Foundation.h>

@interface CPBezierTimings : NSObject

/**	Returns an array of normalized timings (delays from the beginning) for `tickCount` ticks.
	The timings are in the interval ]0, 1[.
	The timings are determined from the given pair of Bezier curve control points.
	The control points must not be equal.
 */
+ (NSArray*) timingsForTicks:(NSUInteger)tickCount cp1:(CGPoint)cp1 cp2:(CGPoint)cp2;

/**	The control points can also be set on a normally `-init`'ed object, after which
	`-timingForTicks:` will return the normalized timings with these control points. */
@property (nonatomic, assign) CGPoint bezierCP1;
@property (nonatomic, assign) CGPoint bezierCP2;
- (NSArray*) timingsForTicks:(NSUInteger)frames;

@end
