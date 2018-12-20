//
//  FontManager.h
//  UNIVERTWO
//
//  Created by 薛安 on 2017/5/19.
//  Copyright © 2017年 com.LiXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FontManager : NSObject

/**
 获取label的约束高度.

 @param oneLabel 上面lable
 @param twoLabel 下面label
 @return 间距
 */
+ (CGFloat)differenceInOneLabel:(UILabel *)oneLabel AndTwoFont:(UILabel *)twoLabel;

/**
 设置lable的attributes字符串

 @param lineSpacing 行间距(不需要处理lable自带间距)
 @param alignment lable的样式
 @param font 字体
 @param textColor 字体颜色
 @return attrubutes字典
 */
+ (NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)alignment Font:(UIFont *)font TextColor:(UIColor *)textColor;

/**
判断是否为手机号
 
 */
+ (BOOL)isMobile:(NSString *)mobileNum;
/**
 判断是否全为中文字符
 */
+ (BOOL)isChineseFormStr:(NSString *)zhongwenStr;
//判断是否为邮箱地址
+ (BOOL)isValidateEmail:(NSString *)email;
@end
