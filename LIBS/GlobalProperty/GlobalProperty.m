//
//  GlobalProperty.m
//  UNIVERTWO
//
//  Created by 薛安 on 2016/12/28.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import "GlobalProperty.h"
static GlobalProperty *_sharedConfig = nil;
@implementation GlobalProperty

+ (instancetype)shareGlobalProperty{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfig = [[GlobalProperty alloc] init];
    });
    return _sharedConfig;
}

- (NSString *)userToken
{
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (userToken.length == 0 || userToken == nil) {
        userToken = @"";
    }
    return userToken;
}

- (NSString *)VerCode{
    static NSString *vi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
        vi =  [infoDictionary objectForKey:@"CFBundleVersion"];
    });
    return vi;
}

- (NSString *)city_Code{
    NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"CITY"];
    if (!cityCode) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"CITY"];
        cityCode = @"";
    }
    return cityCode;
}

- (NSString *)lng_number{
    NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"];
    if (cityCode.length == 0) {
        cityCode = @"";
    }
    return cityCode;
}

- (NSString *)lat_number{
    NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"];
    if (cityCode.length == 0) {
        cityCode = @"";
    }
    return cityCode;
}

- (NSString *)devnum{
    
    NSString *devenum1 = [XAUserDefault objectForKey:@"UUID"];
    if (devenum1.length == 0) {
        devenum1 = @"";
    }
    return devenum1;
    
}

- (NSString *)city_Name{
    
    NSString *devenum1 = [XAUserDefault objectForKey:@"cityName"];
    if (devenum1.length == 0) {
        devenum1 = @"";
    }
    return devenum1;
    
}

@end
