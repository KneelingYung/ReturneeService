//
//  AppDelegate.m
//  UNIVERTWO
//
//  Created by 刘鑫然 on 16/2/27.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import "AppDelegate.h"
#import "BaiduMobStat.h"
#import <JSPatch/JSPatch.h>

#import "PCleadViewController.h"
#import "PCtabBarViewController.h"
#import "LeadingPageViewController.h"
#import "firistPageViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "XANewPersonalVC.h"
#import "FoodHappyViewController.h"
#import "interestPageViewController.h"
#import "NewFristPageViewController.h"
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
#import <MeiQiaSDK/MQManager.h>
#import "AFNetworking.h"
//友盟统计
#import <UMMobClick/MobClick.h>
//侧滑返回
//#import "DLNavigationTransition.h"
#import "DLNavigationViewController.h"

//临时
#import "LXYYouHuiJuanViewController.h"
#import "LXYRenZhengViewController.h"
static NSString * const kStatusBarTappedNotification = @"statusBarTappedNotification";


#define PCTOU  @"http://www.univer.cn/home/NewInterface/avatarAndNickname"
@interface AppDelegate (){
    UITabBarController * tabAcontroler;
}


@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end
//#import "UMSocial.h"
//微信请求头
//#import "UMSocialWechatHandler.h"
//@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [JSPatch startWithAppKey:@"992edf2f1238f4a6"];
    [JSPatch sync];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"orHuoDong"];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        
        //NSLog(@"  Iam ios7");
        
    }
    
    else {
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    
    //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstStart"];
    LeadingPageViewController * leadingbv = [[LeadingPageViewController alloc]init];
    //侧滑返回
    
    //创建分栏显示控制器
   if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
       
       [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
   [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
        self.window.rootViewController = leadingbv;
       
    }else{

    NewFristPageViewController * fristVc = [[NewFristPageViewController alloc]init];
    DLNavigationViewController * fristNc = [[DLNavigationViewController alloc]initWithRootViewController:fristVc];
       
    




        

        XANewPersonalVC *perVc = [[XANewPersonalVC alloc]init];
        DLNavigationViewController * perNc = [[DLNavigationViewController alloc]initWithRootViewController:perVc];
    
    interestPageViewController * serVc = [[interestPageViewController alloc]init];
    DLNavigationViewController * serNc = [[DLNavigationViewController alloc]initWithRootViewController:serVc];
    
    FoodHappyViewController * conVc = [[FoodHappyViewController alloc]init];
    DLNavigationViewController * conNc = [[DLNavigationViewController alloc]initWithRootViewController:conVc];
    
    UITabBarController * tabbarController = [[UITabBarController alloc]init];
        //临时
//        LXYRenZhengViewController *lxy = [[LXYRenZhengViewController alloc]init];
//        DLNavigationViewController * lxytest = [[DLNavigationViewController alloc]initWithRootViewController:lxy];
    self.window.rootViewController = tabbarController;
//        self.window.rootViewController = lxytest;
    NSArray * viewControllersArray = @[fristNc,conNc,serNc,perNc];
//        UIView * mView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, 49)];//这是整个tabbar的颜色
//        //    [mView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_shanchu-1"]]];
//        mView.backgroundColor = [UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:0.9];
//        [tabbarController.tabBar insertSubview:mView atIndex:0];
    tabbarController.viewControllers = viewControllersArray;
        NSArray * titleArray = @[@"工作",@"食乐",@"阅读",@"我的"];
        NSArray * unSelArray = @[@"btn_shouye_h",@"btn_huodong_h",@"btn_xingqu_h",@"btn_wo_h"];
        NSArray * selArray = @[@"btn_shouye_n",@"btn_huodong_n",@"btn_xingqu",@"btn_wo_n"];
    for (int i = 0 ; i<titleArray.count; i++) {
       // UITabBarItem * item = [tabbarController.tabBar.items[i] initWithTitle:titleArray[i] image:[UIImage imageNamed:unSelArray[i]] selectedImage:[UIImage imageNamed:selArray[i]]];
        UITabBarItem * item = [tabbarController.tabBar.items[i] initWithTitle:titleArray[i] image:[[UIImage imageNamed:selArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:unSelArray[i]] imageWithRenderingMode:1]];
        item.title = titleArray[i];
        item.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
        item.titlePositionAdjustment = UIOffsetMake(0, -2);
    }
       
    //tabbarController.tabBar.barTintColor = [UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:0.2];
    
    tabbarController.tabBar.barStyle = UIBarStyleBlack;
    //tabbarController.tabBar.translucent =NO;
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1],NSFontAttributeName :[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1],NSFontAttributeName :[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:119/255.0 blue:17/255.0 alpha:1],NSFontAttributeName :[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    }
    
    
    [UMSocialData setAppKey:@"568cdc8d67e58efbff001d83"];
    [UMSocialQQHandler setQQWithAppId:@"1105034681" appKey:@"568cdc8d67e58efbff001d83" url:@"https://itunes.apple.com/cn/app/univer/id1069859804?mt=8"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"970364415" secret:@"8494db37b2c113c6e1efb16fe9ee4da7" RedirectURL:@"http://www.sharesdk.cn"];
    
    [UMSocialWechatHandler setWXAppId:@"wx34fe4746c3d6eb3f" appSecret:@"3ea33f3e2e99dd757b2e64ccebdd1cd4" url:nil];
    
//    //三方登录
    [ShareSDK registerApp:@"e942ab164322"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
     
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"970364415"
                                           appSecret:@"8494db37b2c113c6e1efb16fe9ee4da7"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx34fe4746c3d6eb3f"
                                       appSecret:@"3ea33f3e2e99dd757b2e64ccebdd1cd4"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105034681"
                                      appKey:@"MwcHAXX3C7acA8da"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
    

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:@"25bba2d889fe0f9e4539f2aa"
                          channel:@"App Store" apsForProduction:1];
    
    
    NSUserDefaults * usert = [NSUserDefaults standardUserDefaults];
    [usert setObject:@"no" forKey:@"islogin"];
    
    [usert synchronize];
    [MQManager initWithAppkey:@"6992800945825843f154a6376e1e4389" completion:^(NSString *clientId, NSError *error) {
    }];
    

    //287d21704b
    //友盟统计
//    [MobClick startWithAppkey:@"568cdc8d67e58efbff001d83" reportPolicy:BATCH   channelId:@""];
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:@"287d21704b"];
    
    
    
    
    
    
    
#warning 判断token是否失效
    NSUserDefaults * p = [NSUserDefaults standardUserDefaults];
    NSString * Ptoken4 = [p objectForKey:@"token"];
    NSLog(@"请求用户头像和姓名Ptoken4 = %@",Ptoken4);
    
    if(Ptoken4.length > 0){
        NSDictionary * dict = @{@"token":Ptoken4};
        [self.manager POST:PCTOU parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               NSLog(@"请求头像信息%@ meseage = %@",responseObject,responseObject[@"message"]);
            
            NSDictionary * dict = [responseObject copy];
            
            if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"100"]) {
            
                NSDictionary *iconAndName = dict[@"appdata"];
                [[NSUserDefaults standardUserDefaults]setObject:iconAndName[@"avatar"] forKey:@"XAavatar"];
                
                 [[NSUserDefaults standardUserDefaults]setObject:iconAndName[@"username"] forKey:@"XAusername"];
            
            }else{
                
                NSUserDefaults * moren = [NSUserDefaults standardUserDefaults];
                [moren setObject:@"no" forKey:@"islogin"];
                [moren setObject:@"" forKey:@"token"];
                
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
                
                [moren synchronize];
            }
         
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
        
        
        
    }else if (Ptoken4.length == 0){
        NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];

        [defs setObject:@"" forKey:@"token"];

    }

    
    
    
    
    
    
    
    
    
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        
        
        
    }
    return result;
}



-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    [JPUSHService registerDeviceToken:deviceToken];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
   [JPUSHService handleRemoteNotification:userInfo];
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    [userInfo setValue:@"0" forKey:@"badge"];
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
   }
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return  [UMSocialSnsService handleOpenURL:url];
}
//- (BOOL)application:(UIApplication *)application




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the applconsultication is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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



- (AFHTTPSessionManager *)manager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
    });
    return manager;
}
@end
