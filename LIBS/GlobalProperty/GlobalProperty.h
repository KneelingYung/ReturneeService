//
//  GlobalProperty.h
//  UNIVERTWO
//
//  Created by 薛安 on 2016/12/28.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalProperty : NSObject

@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *VerCode;
@property (nonatomic, copy) NSString *city_Code;
@property (nonatomic, copy) NSString *city_Name;
@property (nonatomic, copy) NSString *lng_number;
@property (nonatomic, copy) NSString *lat_number;
@property (nonatomic, copy) NSString *devnum;
+ (instancetype)shareGlobalProperty;
@end
