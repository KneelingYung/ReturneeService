//
//  CALayer+CALayer_ZZYXibBorderColor.m
//  UNIVERTWO
//
//  Created by 薛安 on 2017/3/21.
//  Copyright © 2017年 com.LiXiang. All rights reserved.
//

#import "CALayer+CALayer_ZZYXibBorderColor.h"

@implementation CALayer (CALayer_ZZYXibBorderColor)
- (void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

- (UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
