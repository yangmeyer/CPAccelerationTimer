
//  Created by Yang Meyer on 25.01.12.
//  Copyright (c) 2012 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^CPAccelerationTimerTick)(NSUInteger);
typedef void (^CPAccelerationTimerCompletion)();

/**	CPAccelerationTimer calls the `eachTickBlock` a total of `tickCount` times,
	spread out over `duration` seconds, with the delays between calls - i.e. the
	acceleration/deceleration - determined by the Bezier curve defined by `cp1`
	and `cp2`. Finally, the `completionBlock` is called.
	
	Examples for acceleration curves:
		EaseInOut: cp1(0.5, 0.0) cp2(0.5, 1.0)
		Linear:    cp1(0.0, 0.0) cp2(1.0, 1.0)
 */
@interface CPAccelerationTimer : NSObject

// The designated initializer.
- (id) initWithTicks:(NSUInteger)tickCount
	   totalDuration:(NSTimeInterval)duration
	   controlPoint1:(CGPoint)cp1
	   controlPoint2:(CGPoint)cp2
		atEachTickDo:(CPAccelerationTimerTick)eachTickBlock
		  completion:(CPAccelerationTimerCompletion)completionBlock;

+ (id) accelerationTimerWithTicks:(NSUInteger)numberOfTicks
					totalDuration:(NSTimeInterval)duration
					controlPoint1:(CGPoint)cp1
					controlPoint2:(CGPoint)cp2
					 atEachTickDo:(CPAccelerationTimerTick)eachTickBlock
					   completion:(CPAccelerationTimerCompletion)completionBlock;

- (void) run;

@end
