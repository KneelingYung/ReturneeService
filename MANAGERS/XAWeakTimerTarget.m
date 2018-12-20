//
//  XAWeakTimerTarget.m
//  UNIVERTWO
//
//  Created by 薛安 on 2017/6/16.
//  Copyright © 2017年 com.LiXiang. All rights reserved.
//

#import "XAWeakTimerTarget.h"

@interface  XAWeakTimerTarget()

@end


@implementation XAWeakTimerTarget


- (void)fire:(NSTimer *)timer {
    if(self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo];
    } else {
        [self.timer invalidate];
    }
}

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats {
    XAWeakTimerTarget* timerTarget = [[XAWeakTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    return timerTarget.timer;
}



@end
