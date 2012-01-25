
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^CPBezierTick)(NSUInteger);
typedef void (^CPBezierCompletion)();

/**	Runs a simulation for which you can specify the behavior at each "tick".
	Specify the acceleration/deceleration curve by way of the Bezier control points,
	e.g. cp1(0.5, 0.0) cp2(0.5, 1.0) for EaseInOut
		 cp1(0.0, 0.0) cp2(1.0, 1.0) for Linear
 */
@interface CPBezierPacemaker : NSObject

// The designated initializer.
- (id) initWithTicks:(NSUInteger)tickCount
	   totalDuration:(NSTimeInterval)duration
	   controlPoint1:(CGPoint)cp1
	   controlPoint2:(CGPoint)cp2
		atEachTickDo:(CPBezierTick)eachTickBlock
		  completion:(CPBezierCompletion)theCompletionBlock;

+ (id) pacemakerWithTicks:(NSUInteger)numberOfTicks
			totalDuration:(NSTimeInterval)duration
			controlPoint1:(CGPoint)cp1
			controlPoint2:(CGPoint)cp2
			 atEachTickDo:(CPBezierTick)eachTickBlock
			   completion:(CPBezierCompletion)completionBlock;

- (void) run;

@end
