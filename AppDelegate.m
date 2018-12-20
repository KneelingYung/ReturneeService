//
//  AppDelegate.m
//  UNIVERTWO
//
//  Created by 薛安 on 16/2/27.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import "AppDelegate.h"
//#import <JSPatchPlatform/JSPatch.h>

#import "PLHeader.h"
#import <UMSocialCore/UMSocialCore.h>
#import "PCleadViewController.h"
#import "PCtabBarViewController.h"
#import "LXYYouHuiJuanViewController.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "XANewPersonalVC.h"
#import "FoodHappyViewController.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
#import <MeiQiaSDK/MQManager.h>
//友盟统计
#import <UMMobClick/MobClick.h>
//侧滑返回
//#import "DLNavigationTransition.h"
#import "DLNavigationViewController.h"

//跳转
#import "LXYYouHuiJuanViewController.h"
#import "LXYRenZhengViewController.h"
#import "LXYMyYeWuViewController.h"
#import "ZhuanTiTiaoZhuanModel.h"
#import "FootDetailsViewController.h"
#import "ZhuanTiWebViewViewController.h"
#import "particularsViewController.h"
#import "JobDetailViewController.h"
#import "ThemeVC.h"
#import "particularsViewController.h"
#import "SubjectDetailVC.h"
#import "FoodMainViewController.h"
#import "LXYNewH5ActivityViewController.h"
#import "XAChouJiangVC.h"
#import "wenshufanyiViewController.h"
#import "qianzhengViewController.h"
#import "xuelixueweirenzhengViewController.h"
#import "HuiGuoZhengMingViewController.h"
#import "LXYYouHuiJuanViewController.h"
#import "companyLdetailViewController.h"
#import "MessageViewController.h"
//uuid
#import "SFHFKeychainUtils.h"
//#import "SendToViewController.h"
static NSString * const kStatusBarTappedNotification = @"statusBarTappedNotification";
/*广告加载*/
#import <XHLaunchAd.h>

#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()<JPUSHRegisterDelegate,UIGestureRecognizerDelegate>{
    UIView *redview;

    
}


@property (nonatomic, copy) NSString *tiaoZhuanUrl;
@property (nonatomic, strong) ZhuanTiTiaoZhuanModel *model;

@end
//#import "UMSocial.h"
//微信请求头
//#import "UMSocialWechatHandler.h"
//@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置uuid和职位搜索默认条件

    [self setUUID];
//    [self p_emergency];
    [self p_initUi];
    [self p_DiSanFang];
    [self p_push];
    [self p_initNewWorking];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"LXYfirstStart"]){
        [self p_initAd];
    }

#ifdef DEBUG
    //[NSClassFromString(@"UIDebuggingInformationOverlay") performSelector:@selector(prepareDebuggingOverlay)];
  //  [[NSClassFromString(@"UIDebuggingInformationOverlay") performSelector:@selector(overlay)] performSelector:@selector(toggleVisibility)];
#else
    
#endif


   // [[myObj performSelector:NSSelectorFromString(@"overlay")] performSelector:NSSelectorFromString(@"toggleVisibility")];

    
    

    [JPUSHService setupWithOption:launchOptions appKey:@"c6f6887b7fb3d1e739818a11"
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    NSUserDefaults * usert = [NSUserDefaults standardUserDefaults];
    [usert setObject:@"no" forKey:@"islogin"];
    [usert synchronize];
    //    [MobClick startWithAppkey:@"568cdc8d67e58efbff001d83" reportPolicy:BATCH   channelId:@""];
    [self TheTokenIsDismiss];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/Api/Activity/isInviteUserActivityAvailable/";
        request.parameters = nil;
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestType = kXMRequestNormal;
    } onSuccess:^(id  _Nullable responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString *is_available = [NSString stringWithFormat:@"%@",responseObject[@"is_available"]];
        NSLog(@"%@",responseObject);
        if ([code isEqualToString:@"100"]) {
            if ([is_available isEqualToString:@"1"]) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"is_available"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"is_available"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }

    } onFailure:^(NSError * _Nullable error) {
        
    }];
       return YES;
}






-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [MQManager registerDeviceToken:deviceToken];
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the applconsultication is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"outToEnd" object:nil];
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     [MQManager closeMeiqiaService];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [JPUSHService setBadge:0];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0] ;
      [MQManager openMeiqiaService];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]postNotificationName:@"enterInBegin" object:nil];
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

#pragma mark --分享回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    if ([[url absoluteString] rangeOfString:@"wx86085fea81d10caa://pay"].location == 0)
    {
        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        
    }
    return result;
}



- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
//   
    if ([[url absoluteString] rangeOfString:@"wx86085fea81d10caa://pay"].location == 0)
    {
        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            
        }];
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
   if (!result) {
        // 其他如支付等SDK的回调
        return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];


    }
   return result;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint location = [[[event allTouches] anyObject] locationInView:[self window]];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    if (CGRectContainsPoint(statusBarFrame, location)) {
        [self statusBarTouchedAction];
    }
}

- (void)statusBarTouchedAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:kStatusBarTappedNotification
                                                        object:nil];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    NSLog(@"-=-=-=%@",userInfo);
    
    
    if ([userInfo[@"type"] isEqualToString:@"coupon"]) {
        [self goToYouHuiJuan];

    }else if ([userInfo[@"type"] isEqualToString:@"identify"])
    {
        [self goToRenZheng];
    }else if ([userInfo[@"type"] isEqualToString:@"orderStatus"])
    {
        NSString *tiaoZhuanUrl = userInfo[@"url"];
        [self goToWangYeWith:tiaoZhuanUrl];
    }else if ([userInfo[@"type"] isEqualToString:@"banner"])
    {
        
        ZhuanTiTiaoZhuanModel *model = [ZhuanTiTiaoZhuanModel mj_objectWithKeyValues:userInfo[@"info"]];
        NSLog(@"%@",userInfo[@"info"]);
        [self goToSomeVcByData:model];
        
    }
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if (application.applicationState == UIApplicationStateActive){
        NSDictionary *dicc = userInfo[@"aps"];
        NSString *message = [NSString stringWithFormat:@"%@",dicc[@"alert"]];
        [self showAlerterMessage:message andTypee:userInfo];
    }
    if ([userInfo[@"type"] isEqualToString:@"coupon"]&&(application.applicationState != UIApplicationStateActive)) {
        [self goToYouHuiJuan];
    }else if ([userInfo[@"type"] isEqualToString:@"identify"]&&(application.applicationState != UIApplicationStateActive))
    {
        [self goToRenZheng];
    }else if ([userInfo[@"type"] isEqualToString:@"orderStatus"]&&(application.applicationState != UIApplicationStateActive))
    {
        NSString *tiaoZhuanUrl = userInfo[@"url"];
        [self goToWangYeWith:tiaoZhuanUrl];
    }else if ([userInfo[@"type"] isEqualToString:@"banner"])
    {
        ZhuanTiTiaoZhuanModel *model = [ZhuanTiTiaoZhuanModel mj_objectWithKeyValues:userInfo[@"info"]];
        [self goToSomeVcByData:model];
    }
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark  

- (void)p_initNewWorking{
    
    NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
    NSString * vi =  [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [XMCenter setupConfig:^(XMConfig *config) {
        /*设置公共域名*/
        //
#ifdef DEBUG
        config.generalServer = UNIVERSEIVERAPI;
#else
        config.generalServer = UNIVERSEIVERAPI;

#endif  
        /*设置公共参数(由于city在变,导致并不能算在公共参数中)*/
        config.generalParameters = @{@"os":@"ios",@"ver": @"3.2.0",@"devnum":[XAUserDefault objectForKey:@"UUID"]};
        config.callbackQueue = dispatch_get_main_queue();
#ifdef DEBUG
        config.consoleLog = YES;
#endif
    }];
}
//
//- (void)p_emergency{
//    //应急措施
//    [JSPatch startWithAppKey:@"992edf2f1238f4a6"];
//    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIQUJn3j8qyxd0smY2jmVXVE56\n6kLALK6RblHtOIzMZvCWyZjTpR5y2YxpZtQqQIRxRLmN/4g66nSX1RElqvFh9Y1i\n0mDzRxao9QZ1d4ierF2NqryGTdsec8UL9lIoegGKd5XY5khfoW4KpJacQ8sRuPNr\nYQzeQNbcDhhhO+tTYwIDAQAB\n-----END PUBLIC KEY-----"];
//    //[JSPatch testScriptInBundle];
//    //[JSPatch sync];
// //   [JSPatch setupDevelopment];
//    #ifdef DEBUG
//    #endif
//    [JSPatch sync];
//   // [JSPatch showDebugView];
//}

- (void)p_DiSanFang{
   // 友盟第三方登录
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"568cdc8d67e58efbff001d83"];
    
    
    //微信聊天
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx86085fea81d10caa" appSecret:@"1bec5b44176e0fce4e2a5ec110f64832" redirectURL:@"http://mobile.umeng.com/social"];
    //微信朋友圈
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wx86085fea81d10caa" appSecret:@"1bec5b44176e0fce4e2a5ec110f64832" redirectURL:@"http://mobile.umeng.com/social"];
    
    //qq
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105034681" appSecret:@"568cdc8d67e58efbff001d83" redirectURL:@"http://mobile.umeng.com/social"];
    //weibo
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"970364415" appSecret:@"8494db37b2c113c6e1efb16fe9ee4da7" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //统计
    
    UMConfigInstance.appKey = @"568cdc8d67e58efbff001d83";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    //关闭崩溃上传
    [MobClick setCrashReportEnabled:YES];
    //三方登录

    //美洽客服
    [MQManager initWithAppkey:@"6992800945825843f154a6376e1e4389" completion:^(NSString *clientId, NSError *error) {
    }];
    //界面统计
   // BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
  //  statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
   // statTracker.enableDebugOn = YES;
#ifdef DEBUG
    // Debug 模式的代码...
#else
    // Release 模式的代码...

   // [statTracker startWithAppId:@"50abbc93c0"];
#endif

}

- (void)p_initUi{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    PCtabBarViewController *tabbar = [PCtabBarViewController sharedRootViewController];
    self.window.rootViewController = tabbar;
}

- (void)p_push{
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    

}

- (void)p_initAd{
    [XHLaunchAd setWaitDataDuration:3];
    
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/Api/SystemBooting/index/";
        request.parameters = @{@"mod":@"openad"};
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestType = kXMRequestNormal;
    } onSuccess:^(id  _Nullable responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"100"]) {
        self.model = [ZhuanTiTiaoZhuanModel mj_objectWithKeyValues:responseObject[@"data"][@"result"]];
         
                XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
                
                imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                imageAdconfiguration.duration = self.model.duration.integerValue;
                //    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
                NSString *height = nil;
                switch ((int)screen_Height) {
                    case 568:
                        height = @"1136";
                        break;
                    case 667:
                        height = @"1334";
                        break;
                    case 736:
                        height = @"2208";
                        break;
                        
                    default:
                        break;
                }
                imageAdconfiguration.imageNameOrURLString = self.model.pics[height];
                //    //网络图片缓存机制(只对网络图片有效)
                imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
                //    //图片填充模式
                imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
                //    //广告点击打开链接
                imageAdconfiguration.openURLString = self.model.jump_type;
                //    //广告显示完成动画
                imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
                //    //跳过按钮类型
                imageAdconfiguration.skipButtonType = SkipTypeNone;
                
                imageAdconfiguration.customSkipView = [self customSkipView];
                
                //    //后台返回时,是否显示广告
                imageAdconfiguration.showEnterForeground = NO;
                //
                //设置要添加的子视图(可选)
                //    imageAdconfiguration.subViews = ...
                
                //显示图片开屏广告
                [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
                [UIView animateWithDuration:self.model.duration.integerValue-0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    [XHLaunchAd shareLaunchAd].adView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.1f, 1.1f, 1.1f);
                } completion:^(BOOL finished) {
                    //        self.btnWindow.hidden = YES;
                    //        self.btnWindow = nil;
                }];
        
        }
    } onFailure:^(NSError * _Nullable error) {
        
    }];
    
    
    
    
}

#pragma mark --广告代理
/*
 广告点击代理
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString{
    if(![openURLString isEqualToString:@"3"])
    {
        NSLog(@"点击广告");
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.api = @"/Api/SystemBooting/index";
            request.parameters = @{@"mod":@"adverclick",@"id":self.model.tanId};
            request.httpMethod = kXMHTTPMethodPOST;
            request.requestType = kXMRequestNormal;
        } onSuccess:^(id  _Nullable responseObject) {
            
        } onFailure:^(NSError * _Nullable error) {
            
        }];
        
        [self goToSomeVcByData:self.model];
        [[XHLaunchAd shareLaunchAd] remove];
    }
}
/*
广告倒数代理
*/
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration{
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    [button setTitle:[NSString stringWithFormat:@"%ld",duration] forState:UIControlStateNormal];

}
/*
跳过按钮
*/
-(void)skipAction{
    [XHLaunchAd skipAction];
   
}


-(UIView *)customSkipView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_tiaozhuan"] forState:UIControlStateNormal];
    button.frame = CGRectMake(screen_Width-14-45, 14+20,45 , 45);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitle:@"3" forState:UIControlStateNormal];
    UILabel *JumpLabel = [UILabel new];
    JumpLabel.text = @"跳过";
    JumpLabel.textColor = [UIColor whiteColor];
    JumpLabel.font = [UIFont systemFontOfSize:12];
    [button addSubview:JumpLabel];
    [JumpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button.mas_centerX);
        make.top.equalTo(button.mas_top).with.offset(12);
    }];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -20, 0);
    [button addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}





#pragma mark - 判断token是否失效
- (void)TheTokenIsDismiss{

    NSUserDefaults * p = [NSUserDefaults standardUserDefaults];
    NSString * Ptoken4 = [p objectForKey:@"token"];
    if(Ptoken4.length > 0){
        
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.api = @"/home/NewInterface/avatarAndNickname";
            request.parameters = @{@"token":Ptoken4};
            request.httpMethod = kXMHTTPMethodPOST;
            request.requestType = kXMRequestNormal;
        } onSuccess:^(id  _Nullable responseObject) {
            NSDictionary * dict = [responseObject copy];
            if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"100"]) {
                NSDictionary *iconAndName = dict[@"appdata"];
                [[NSUserDefaults standardUserDefaults]setObject:iconAndName[@"avatar"] forKey:@"XAavatar"];
                [[NSUserDefaults standardUserDefaults]setObject:iconAndName[@"username"] forKey:@"XAusername"];
                [JPUSHService setTags:nil  alias:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
                    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
                }];
                
                NSString *isrenzheng = [NSString stringWithFormat:@"%@",iconAndName[@"is_verified"]];
                if([isrenzheng isEqualToString:@"1"]){
                    
                    [XAUserDefault setObject:iconAndName[@"verified_school"] forKey:@"verified_school"];
                    
                }else{
                    
                    [XAUserDefault setObject:@"" forKey:@"verified_school"];
                }
                
                
            }else{
                NSUserDefaults * moren = [NSUserDefaults standardUserDefaults];
                [moren setObject:@"no" forKey:@"islogin"];
                [moren setObject:@"" forKey:@"token"];
                
                [moren setObject:@"" forKey:@"XAavatar"];
                [moren setObject:@"未登录"forKey:@"XAusername"];
                
                [moren setObject:@"" forKey:@"gender"];
                [moren setObject:@"" forKey:@"univer"];
                [moren setObject:@"" forKey:@"gename"];
                [moren setObject:@"" forKey:@"hometown"];
                [moren setObject:@"" forKey:@"avatar"];
                [moren setObject:@"" forKey:@"username"];
                [moren setObject:@"" forKey:@"password"];
                [moren setObject:@"" forKey:@"gerentouxiang"];
                [moren setObject:@"" forKey:@"gerenming"];
                [moren setObject:@"" forKey:@"zy"];
                [moren setObject:@"" forKey:@"age"];
                [moren setObject:@"" forKey:@"images"];
                
                [moren setObject:@"" forKey:@"verified_school"];
                [moren synchronize];
            }
            
            
            
            

        } onFailure:^(NSError * _Nullable error) {
            [XAUserDefault setObject:@"未登录"forKey:@"XAusername"];
            [XAUserDefault setObject:@""forKey:@"XAavatar"];
            [XAUserDefault setObject:@"" forKey:@"token"];
            [XAUserDefault synchronize];
        }];
        
           }else if (Ptoken4.length == 0){
        NSUserDefaults * moren = [NSUserDefaults standardUserDefaults];
        
        [moren setObject:@"" forKey:@"token"];
        [XAUserDefault setObject:@"未登录"forKey:@"XAusername"];
        [XAUserDefault setObject:@""forKey:@"XAavatar"];
        
        [moren synchronize];
        [JPUSHService setTags:nil  alias:@""  fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
            NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
        }];
        
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"orKaiChang"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"orCeHua"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"orShouCang"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"readHistory"];
 


}


//本地显示
- (void)showAlerterMessage:(NSString *)messageString andTypee:(NSDictionary *)notificationType{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    redview = [UIView new];
    redview.backgroundColor = [UIColor clearColor];
    redview.frame = CGRectMake(0, -64, screen_Width, 64);
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, screen_Width, 64);
    [redview addSubview:effectview];
     redview.userInteractionEnabled = YES;
    if ([notificationType[@"type"] isEqualToString:@"identify"]) {
        UITapGestureRecognizer * tapRenZheng = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRenZhengTo:)];
        tapRenZheng.delegate = self;
        [redview addGestureRecognizer:tapRenZheng];
    }else if([notificationType[@"type"] isEqualToString:@"coupon"]){
        //点击手势
        UITapGestureRecognizer * tapSend = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSendTo:)];
        tapSend.delegate = self;
        [redview addGestureRecognizer:tapSend];
    }else if([notificationType[@"type"] isEqualToString:@"orderStatus"]){
        //点击手势
        UITapGestureRecognizer * tapSend = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapYeWuTo:)];
        tapSend.delegate = self;
        self.tiaoZhuanUrl = notificationType[@"url"];
        [redview addGestureRecognizer:tapSend];
    }

    
    
    
    //向右轻扫手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionUp; //设置轻扫方向；默认是 UISwipeGestureRecognizerDirectionRight，即向右轻扫
    recognizer.delegate = self;
    
    [redview addGestureRecognizer:recognizer];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:redview];
    
    [[UIApplication sharedApplication].keyWindow
     insertSubview:redview atIndex:1001];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 7.5, 20, 20)];
    iconView.image = [UIImage imageNamed:@"LOGOuniver"];
    [redview addSubview:iconView];
    
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 12, 7.5, 20, 25)];
    namelabel.text = @"海归服务";
    namelabel.textAlignment = NSTextAlignmentCenter;
    namelabel.textColor = [UIColor whiteColor];
    [namelabel sizeToFit];
    [namelabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [redview addSubview:namelabel];
    
    UILabel *Nowlabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelabel.frame) + 10, 10, 20, 25)];
    Nowlabel.text = @"现在";
    Nowlabel.textAlignment = NSTextAlignmentCenter;
    Nowlabel.textColor = [UIColor blackColor];
    Nowlabel.font = [UIFont systemFontOfSize:11];
    [Nowlabel sizeToFit];
    [redview addSubview:Nowlabel];
    
    
    
    UILabel *messageLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(namelabel.frame), CGRectGetMaxY(namelabel.frame), screen_Width - CGRectGetMinX(namelabel.frame) -20, 25)];
    messageLable.text = messageString;
    messageLable.textAlignment = NSTextAlignmentLeft;
    messageLable.textColor = [UIColor whiteColor];
    
    messageLable.numberOfLines = 2;
    messageLable.font = [UIFont systemFontOfSize:11];
    [messageLable sizeToFit];
    [redview addSubview:messageLable];
    
    
    
    
    [UIView animateWithDuration:0.4 animations:^{
            redview.frame = CGRectMake(0, 0, screen_Width, 64);
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1 animations:^{
                    redview.frame = CGRectMake(0, -64, screen_Width, 64);
    
                } completion:^(BOOL finished) {
                    [redview removeFromSuperview];
                    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
                }];
            });
        }];

    
}

//优惠券页面
- (void)tapSendTo:(UIGestureRecognizer *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        redview.frame = CGRectMake(0, -64, screen_Width, 64);
    } completion:^(BOOL finished) {
        [redview removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    }];
    [self goToYouHuiJuan];
    
    
}


//上滑手势
- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    
    [UIView animateWithDuration:0.1 animations:^{
        redview.frame = CGRectMake(0, -64, screen_Width, 64);
    } completion:^(BOOL finished) {
        
        [redview removeFromSuperview];
         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    }];
    
    
}


//认证跳转
- (void)tapRenZhengTo:(UIGestureRecognizer *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        redview.frame = CGRectMake(0, -64, screen_Width, 64);
    } completion:^(BOOL finished) {
        [redview removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    }];
    [self goToRenZheng];
}

- (void)tapYeWuTo:(UIGestureRecognizer *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        redview.frame = CGRectMake(0, -64, screen_Width, 64);
    } completion:^(BOOL finished) {
        [redview removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    }];
    [self goToWangYeWith:self.tiaoZhuanUrl];
}
#pragma mark --全局调转
- (void)goToSomeVcByData:(ZhuanTiTiaoZhuanModel *)model{
    PCtabBarViewController *tabbar = [[PCtabBarViewController alloc]init];
    self.window.rootViewController = tabbar;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"orKaiChang"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    tabbar.selectedIndex = 0;
    DLNavigationViewController *dl =(DLNavigationViewController *)  tabbar.selectedViewController;
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if ([model.jump_type isEqualToString:@"3"]) {
        return;
    }
    
    //直接跳转
    if ([model.jump_type isEqualToString:@"2"]) {
        LXYMyYeWuViewController *vc = [[LXYMyYeWuViewController alloc]init];
        vc.Url = model.html_url;
        vc.hidesBottomBarWhenPushed = YES;
        vc.tiaoZhuanType = LXYTianZhuanTypeZhiJie;
        [dl pushViewController:vc animated:YES];
    }else{
        NSArray *items = @[@"food",@"topic",@"job",@"theme",@"article",@"activity",@"service",@"coupon",@"enterprise",@"meiqia"];
        LXYPushVcType type = [items indexOfObject:model.app_model];
        
        switch (type){
                //食乐详情
            case LXYPushVcTypeFood:{
                FootDetailsViewController *vc = [[FootDetailsViewController alloc]init];
                vc.orZhuanChang = NO;
                vc.tanId = model.app_para_id;
                vc.hidesBottomBarWhenPushed = YES;
                [dl pushViewController:vc animated:YES];
            }
                break;
                //专题
            case LXYPushVcTypeTopic:{
                ZhuanTiWebViewViewController *vc = [[ZhuanTiWebViewViewController alloc]init];
                vc.Url = model.app_url;
                vc.hidesBottomBarWhenPushed = YES;
                
                [dl pushViewController:vc animated:YES];
            }
                break;
                //工作
            case LXYPushVcTypeJob:{
                JobDetailViewController *vc = [[JobDetailViewController alloc]init];
                vc.ID = model.app_para_id;
                vc.hidesBottomBarWhenPushed = YES;
                [dl pushViewController:vc animated:YES];
            }
                break;
                //兴趣主题
            case LXYPushVcTypeTheme:{
                ThemeVC *vc = [[ThemeVC alloc]init];
                vc.theme_id = model.app_para_id;
                vc.hidesBottomBarWhenPushed = YES;
                [dl pushViewController:vc animated:YES];
                
            }
                break;
                //兴趣文章
            case LXYPushVcTypeArticle:{
                //Native
                if ([model.app_model_child isEqualToString:@"1"]) {
                    particularsViewController *vc = [[particularsViewController alloc]init];
                    vc.article_id = model.app_para_id;
                    vc.hidesBottomBarWhenPushed = YES;
                    [dl pushViewController:vc animated:YES];
                }else{
                    //H5

                    SubjectDetailVC *objectVC = [[SubjectDetailVC alloc] init];
                    //objectVC.zhutiStr = articleData.name;
                    objectVC.url = model.app_model_child_url;
                    objectVC.article_id = model.app_para_id;
                    objectVC.hidesBottomBarWhenPushed = YES;
                    [dl pushViewController:objectVC animated:YES];
                }
                
            }
                break;
            case LXYPushVcTypeActivity:{
                switch (model.app_model_child.integerValue) {
                    case 1:
                    {
                        //邀请活动
                        LXYNewH5ActivityViewController *vc = [[LXYNewH5ActivityViewController alloc]init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [dl pushViewController:vc animated:YES];
                    }
                        break;
                    case 2:
                    {
                        //抽奖活动
                        XAChouJiangVC *vc = [[XAChouJiangVC alloc]init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [dl pushViewController:vc animated:YES];
                    }
                        break;
                    case 3:
                    {
                        //h5活动
                        if (userToken.length > 0) {
                            NSString *Url = [NSString stringWithFormat:@"%@token/%@",model.app_model_child_url,userToken];
                            LXYMyYeWuViewController *vc = [[LXYMyYeWuViewController alloc]init];
                            vc.Url = Url;
                            vc.tiaoZhuanType = LXYTianZhuanTypeZhiJie;
                            vc.hidesBottomBarWhenPushed = YES;
                            [dl pushViewController:vc animated:YES];
                        }else{
                            LXYMyYeWuViewController *vc = [[LXYMyYeWuViewController alloc]init];
                            vc.Url = model.app_model_child_url;
                            vc.tiaoZhuanType = LXYTianZhuanTypeZhiJie;
                            vc.hidesBottomBarWhenPushed = YES;
                            [dl pushViewController:vc animated:YES];
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            case LXYPushVcTypeService:{
                switch (model.app_model_child.integerValue) {
                    case 1:
                    {
                        //学历学位认证
                        xuelixueweirenzhengViewController *vc = [[xuelixueweirenzhengViewController alloc]init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [dl pushViewController:vc animated:YES];
                    }
                        break;
                    case 2:
                    {
                        //文书翻译
                        wenshufanyiViewController *vc = [[wenshufanyiViewController alloc]init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [dl pushViewController:vc animated:YES];
                    }
                        break;
                    case 3:
                    {
                        //签证办理
                        qianzhengViewController *vc = [[qianzhengViewController alloc]init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [dl pushViewController:vc animated:YES];
                    }
                        break;
                    case 4:
                    {
                        //回国证明
                        HuiGuoZhengMingViewController *vc = [[HuiGuoZhengMingViewController alloc]init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [dl pushViewController:vc animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            case LXYPushVcTypeCoupon:
            {
                //优惠券
                if (userToken > 0) {
                    LXYYouHuiJuanViewController *vc = [[LXYYouHuiJuanViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [dl pushViewController:vc animated:YES];
                    
                }else{
                    PloadViewController * vc = [[PloadViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.isdneg = 2;
                    [dl presentViewController:vc animated:YES completion:^{
                        
                    }];
                    
                    
                    
                }
            }
                break;
            case LXYPushVcTypeEnterprise:
            {
                //企业详情
                companyLdetailViewController *vc = [[companyLdetailViewController alloc]init];
                vc.IdString = model.app_para_id;
                vc.hidesBottomBarWhenPushed = YES;
                [dl pushViewController:vc animated:YES];
            }
                break;
            case LXYPushVcTypemeiqia:
            {
                tabbar.selectedIndex = 2;
                DLNavigationViewController *d4 =(DLNavigationViewController *)  tabbar.selectedViewController;
                NSLog(@"%@",d4.topViewController
                      );
                //企业详情
                
                MessageViewController *vc =  (MessageViewController *)d4.topViewController;
//                [vc meiqiawith:@"在线客服"];
            }
                break;

            default:
                break;
        }
        
    }
    
}
#pragma mark -- 推送跳转
- (void)goToYouHuiJuan{
    LXYYouHuiJuanViewController *dv = [[LXYYouHuiJuanViewController alloc] init];
    PCtabBarViewController *tabbar = [[PCtabBarViewController alloc]init];
    self.window.rootViewController = tabbar;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"orKaiChang"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    tabbar.selectedIndex = 3;
    DLNavigationViewController *dl =(DLNavigationViewController *)  tabbar.selectedViewController;
    dv.hidesBottomBarWhenPushed = YES;
    [dl pushViewController:dv animated:YES];
}

- (void)goToRenZheng{
    LXYRenZhengViewController *dv = [[LXYRenZhengViewController alloc] init];
    PCtabBarViewController *tabbar = [[PCtabBarViewController alloc]init];
    self.window.rootViewController = tabbar;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"orKaiChang"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    tabbar.selectedIndex = 3;
    DLNavigationViewController *dl =(DLNavigationViewController *)  tabbar.selectedViewController;
    dv.hidesBottomBarWhenPushed = YES;
    [dl pushViewController:dv animated:YES];
}

- (void)goToWangYeWith:(NSString *)TiaoZhuanUrl{
    LXYMyYeWuViewController *dv = [[LXYMyYeWuViewController alloc] init];
    dv.Url = TiaoZhuanUrl;
    dv.tiaoZhuanType = LXYTianZhuanTypeZhiJie;
    PCtabBarViewController *tabbar = [[PCtabBarViewController alloc]init];
    self.window.rootViewController = tabbar;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"orKaiChang"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    tabbar.selectedIndex = 3;
    DLNavigationViewController *dl =(DLNavigationViewController *)  tabbar.selectedViewController;
    dv.hidesBottomBarWhenPushed = YES;
    [dl pushViewController:dv animated:YES];
}


- (AFHTTPSessionManager *)manager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
    });
    return manager;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}


//设置uuid
- (void)setUUID{
    //生成uuid
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"XKLSKJ" andServiceName:@"LP" error:nil];
    if (uuid.length == 0) {
        //生成uuid
        [SFHFKeychainUtils storeUsername:@"XKLSKJ" andPassword:[self uuid] forServiceName:@"LP" updateExisting:1 error:nil];
        
        NSString *uuid1 =  [SFHFKeychainUtils getPasswordForUsername:@"XKLSKJ" andServiceName:@"LP" error:nil];
        
        [XAUserDefault setObject:uuid1 forKey:@"UUID"];
        
        NSLog(@"%@",uuid1);
        
    }else{
        
        [XAUserDefault setObject:uuid forKey:@"UUID"];
        
        
    }

}

//生成uuid
-(NSString *) uuid{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


#pragma mark - 微信支付相关

- (void)onResp:(BaseResp *)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"-errcode:%d", resp.errCode];
    NSString *strTitle;
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;

    }
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    
    if([resp isKindOfClass:[PayResp class]]){
#warning 4.支付返回结果，实际支付结果需要去自己的服务器端查询  由于demo的局限性这里直接使用返回的结果
        strTitle = [NSString stringWithFormat:@"支付结果"];
        // 返回码参考：https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=9_12
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
                
            default:{
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
                
        }
        
    }
    

}

@end
