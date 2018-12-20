//
//  XAWeakTimerTarget.h
//  UNIVERTWO
//
//  Created by 薛安 on 2017/6/16.
//  Copyright © 2017年 com.LiXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XAWeakTimerTarget : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;
@end
