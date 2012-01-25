
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012 compeople AG. All rights reserved.

#import "CPBezierPacemaker.h"
#import "CPBezierTimings.h"

@interface CPBezierPacemaker ()
@property (nonatomic) NSUInteger numberOfTicks;
@property (nonatomic) NSTimeInterval totalDuration;
@property (nonatomic, copy) CPBezierTick tickBlock;
@property (nonatomic, copy) CPBezierCompletion completionBlock;
@property (nonatomic, retain) NSArray* absoluteTickTimings; // absolute delays from the beginning, normalized to [0, 1]

- (void) runTick:(NSNumber*)tickIndexNumber;
@end

@implementation CPBezierPacemaker

@synthesize numberOfTicks, totalDuration, tickBlock, completionBlock;
@synthesize absoluteTickTimings;

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
		atEachTickDo:(CPBezierTick)eachTickBlock
		  completion:(CPBezierCompletion)theCompletionBlock {
	self = [super init];
	if (self) {
		self.numberOfTicks = tickCount;
		self.totalDuration = duration;
		self.tickBlock = eachTickBlock;
		self.completionBlock = theCompletionBlock;
		self.absoluteTickTimings = [CPBezierTimings timingsForTicks:tickCount cp1:cp1 cp2:cp2];
		NSAssert([self.absoluteTickTimings count] == self.numberOfTicks,
				 @"Must have calculated as many tick delays as there are ticks");
	}
	return self;
}

+ (id) pacemakerWithTicks:(NSUInteger)tickCount
			totalDuration:(NSTimeInterval)duration
			controlPoint1:(CGPoint)cp1
			controlPoint2:(CGPoint)cp2
			 atEachTickDo:(CPBezierTick)eachTickBlock
			   completion:(CPBezierCompletion)completionBlock {
	return [[[self alloc] initWithTicks:tickCount
						  totalDuration:duration
						  controlPoint1:cp1
						  controlPoint2:cp2
						   atEachTickDo:eachTickBlock
							 completion:completionBlock] autorelease];
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
										 : [[self.absoluteTickTimings objectAtIndex:tickIndex+1] doubleValue]);
		NSTimeInterval currentTickTiming = [[self.absoluteTickTimings objectAtIndex:tickIndex] doubleValue];
		NSTimeInterval currentTickDuration = (nextTickTiming - currentTickTiming);
		NSTimeInterval nextTickDelay = self.totalDuration * currentTickDuration;
		[self performSelector:@selector(runTick:)
				   withObject:[NSNumber numberWithUnsignedInteger:tickIndex+1]
				   afterDelay:nextTickDelay];
	}
}

@end
