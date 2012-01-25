CPBezierPacemaker
===================

Run a simulation with a given acceleration curve and specific behavior at each “tick”. Think of it as an NSTimer with not-necessarily-linear delays.

Example “Accelerating and decelarting heartbeat”:

	[[CPBezierPacemaker pacemakerWithTicks:10
			totalDuration:20.0
			controlPoint1:CGPointMake(0.7, 0.0) // ease in
			controlPoint2:CGPointMake(0.5, 1.0) // ease out
			atEachTickDo:^(NSUInteger tickIndex) {
				self.heart.transform = CGAffineTransformIdentity;
				[UIView animateWithDuration:0.3 animations:^{
					self.heart.transform = CGAffineTransformMakeScale(1.2, 1.2);
				}];
			} completion:^{
				self.heart.transform = CGAffineTransformIdentity;
		}]
	run];

Feel free to comment, fork, and submit pull requests!

Requirements
------------
* This component was _not_ built under [ARC](http://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/_index.html); if your project is compiled under ARC, make sure to specify the `-fno-objc-arc` flag on this component’s files in Build phases > Compile sources.

License
-------
The CPBezierPacemaker component is released under the MIT License.

The MIT License (MIT)
Copyright (c) 2012 compeople AG

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
