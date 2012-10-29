
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012 compeople. All rights reserved.

#import "CPBezierTimings.h"
#import "Bezier.h"

@interface CPBezierTimings ()
@property (nonatomic, retain) NSMutableArray* absoluteDelays;
@end

@implementation CPBezierTimings

@synthesize absoluteDelays;
@synthesize bezierCP1, bezierCP2;

- (id) init {
	self = [super init];
	if (self) {
		self.absoluteDelays = [[NSMutableArray alloc] initWithCapacity:30];
	}
	return self;
}

- (NSArray*) timingsForTicks:(NSUInteger)tickCount {
	NSAssert(!CGPointEqualToPoint(self.bezierCP1, self.bezierCP2),
			 @"The control points must be different from one another.");
	NSUInteger lastMultiples = 0;
	NSTimeInterval lastMilestoneTime = 0.0;
	NSTimeInterval thisMilestoneTime = 0.0;
	NSTimeInterval thisIntervalFromLast = 0.0;
	float x = 0.0;
	float step = 0.001;
	while (x < 1.0-step) {
		float y = cubicBezier(x, bezierCP1.x, bezierCP1.y, bezierCP2.x, bezierCP2.y);
		NSUInteger milestonesPassed = (NSUInteger) (y * tickCount);
		BOOL crossedAMilestone = (milestonesPassed > lastMultiples);
		if (crossedAMilestone) {
			thisIntervalFromLast = x - lastMilestoneTime;
			lastMilestoneTime = thisMilestoneTime;
			[self.absoluteDelays addObject:[NSNumber numberWithDouble:thisIntervalFromLast]];
            //			NSLog(@"%.4f - %@ (%d->%d)", thisIntervalFromLast, [@"" stringByPaddingToLength:milestonesPassed withString:@"x" startingAtIndex:0], milestonesPassed-1, milestonesPassed);
		}
		lastMultiples = milestonesPassed;
		x += step;
	}
	return [NSArray arrayWithArray:self.absoluteDelays];
}

+ (NSArray*) timingsForTicks:(NSUInteger)tickCount cp1:(CGPoint)cp1 cp2:(CGPoint)cp2 {
	CPBezierTimings* calculator = [CPBezierTimings new];
	calculator.bezierCP1 = cp1;
	calculator.bezierCP2 = cp2;
	[calculator timingsForTicks:tickCount];
	return calculator.absoluteDelays;
}

@end
