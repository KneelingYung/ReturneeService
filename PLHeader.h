//
//  PLHeader.h
//  UNIVERTWO
//
//  Created by 我在路上 on 16/3/18.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#ifndef PLHeader_h
#define PLHeader_h
#define screen_Height [UIScreen mainScreen].bounds.size.height
#define screen_Width [UIScreen mainScreen].bounds.size.width



#define nav_Height 64.0f
#define tabBar_Height 49.0f
#define iphone_4 320.0f
#define iphone_5 320.0f
#define iphone_6 375.0f
#define iphone_6p 414.0f
#define Hiphone_4  480.0f
#define Hiphone_5 568.0f
#define JIXINGSHIPEI [UIScreen mainScreen].bounds.size.height/667

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "PlainPhotoBrose.h"
#import <SDAutoLayout.h>
#import "NetRequest.h"
#import <SDAutoLayout.h>
#import <Masonry.h>
#import <MJExtension.h>
#import <ZFPlayer.h>
#import "NSAttributedString+NSAttributedStringSize.h"
#import "NSString+Extensio.h"
//tag值的使用情况
//200- 210,个人资料页面个人资料的使用。
//220 － 229  个人中心性别选择。

//9月个人中心页面重构
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define ProportionWidth [UIScreen mainScreen].bounds.size.width/375
#define proportionHight [UIScreen mainScreen].bounds.size.height/667

#define XAUserDefault  [NSUserDefaults standardUserDefaults]

#define RGBColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define XANSUserDefaults [NSUserDefaults standardUserDefaults]


//500 510 520






















// 230 - 249 设置页面的按钮

//250 - 259 ,密码修改
//260 － 279，引导页登录按钮。
//280-－ 289，手机／邮箱注册页面的
//300 -- 309  登录页面的两个按钮的使用
//项目修改后300 － 309 －－登陆页三方登录使用－－－－
//320 -- 329  .手机快速登录

//330- 339  用户密码找回输入框使用。
//340- 349  用户密码找回，标题使用。
//350 - 359 我的万能问四个大按钮的图标
//360 - 369 我的万能问四个大按钮图标的数量显示。
//最新一期的修改使用
//350 －359 找工作页面三个按钮的对调使用
//找工作详情页使用400，使用情况如下
//400 - 429.是找工作详情使用的
//我个人中心大页面使用 430-－－ 439
//改绑手机使用 440；
//修改密码使用  460 －－469；

//在第三方登录登录的情况下，
//470  ------ 479.
//我的消息界面使用
//480-- 489
//我的收藏界面设计用
//490 －－ 499


#define PCWANDETAIL  @"/home/NewInterface/memberQuestionLists"
#define  SANFANFDENG  @"/home/NewInterface/appLogin"

#endif /* PLHeader_h */
