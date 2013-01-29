
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012-2013 compeople AG et al. All rights reserved.

#import "CPAccelerationTimer.h"
#import "CPBezierTimings.h"

@interface CPAccelerationTimer ()
@property (nonatomic) NSUInteger numberOfTicks;
@property (nonatomic) NSTimeInterval totalDuration;
@property (nonatomic, copy) CPAccelerationTimerTick tickBlock;
@property (nonatomic, copy) CPAccelerationTimerCompletion completionBlock;
@property (nonatomic, retain) NSArray* absoluteTickTimings; // absolute delays from the beginning, normalized to [0, 1]

- (void) runTick:(NSNumber*)tickIndexNumber;
@end

@implementation CPAccelerationTimer

#pragma mark - Lifecycle

// Override super's DI.
- (id) init {
	NSAssert(NO, @"Cannot initialize without parameters. Use -initWithTicks:... instead");
	return nil;
}

// The designated initializer.
- (id) initWithTicks:(NSUInteger)tickCount
	   totalDuration:(NSTimeInterval)duration
	   controlPoint1:(CGPoint)cp1
	   controlPoint2:(CGPoint)cp2
		atEachTickDo:(CPAccelerationTimerTick)eachTickBlock
		  completion:(CPAccelerationTimerCompletion)theCompletionBlock {
	self = [super init];
	if (self) {
		self.numberOfTicks = tickCount;
		self.totalDuration = duration;
		self.tickBlock = eachTickBlock;
		self.completionBlock = theCompletionBlock;
		self.absoluteTickTimings = [[CPBezierTimings timingsForTicks:tickCount cp1:cp1 cp2:cp2] subarrayWithRange:NSMakeRange(0, self.numberOfTicks - 1)];
	}
	return self;
}

+ (id) accelerationTimerWithTicks:(NSUInteger)tickCount
					totalDuration:(NSTimeInterval)duration
					controlPoint1:(CGPoint)cp1
					controlPoint2:(CGPoint)cp2
					 atEachTickDo:(CPAccelerationTimerTick)eachTickBlock
					   completion:(CPAccelerationTimerCompletion)completionBlock {
	return [[self alloc] initWithTicks:tickCount
                         totalDuration:duration
                         controlPoint1:cp1
                         controlPoint2:cp2
                          atEachTickDo:eachTickBlock
                            completion:completionBlock];
}

- (void) dealloc {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	self.tickBlock = nil;
	self.completionBlock = nil;
	self.absoluteTickTimings = nil;
}

#pragma mark -

- (void) run {
	[self runTick:[NSNumber numberWithUnsignedInteger:0]];
}

- (void) runTick:(NSNumber*)tickIndexNumber {
	[NSObject cancelPreviousPerformRequestsWithTarget:self]; // balance the performSelector request below
	NSUInteger tickIndex = [tickIndexNumber unsignedIntegerValue];
	
	BOOL simulationCompleted = (tickIndex >= self.numberOfTicks);
	if (simulationCompleted) {
		self.completionBlock();
	} else {
		self.tickBlock(tickIndex);
		
		NSTimeInterval nextTickTiming = (tickIndex == self.numberOfTicks-1
										 ? 1.0
										 : [[self.absoluteTickTimings objectAtIndex:tickIndex] doubleValue]);
		NSTimeInterval currentTickTiming = (tickIndex == 0
											? 0.0
											: [[self.absoluteTickTimings objectAtIndex:tickIndex-1] doubleValue]);
		NSTimeInterval currentTickDuration = (nextTickTiming - currentTickTiming);
		NSTimeInterval nextTickDelay = self.totalDuration * currentTickDuration;
		[self performSelector:@selector(runTick:)
				   withObject:[NSNumber numberWithUnsignedInteger:tickIndex+1]
				   afterDelay:nextTickDelay];
	}
}

@end
