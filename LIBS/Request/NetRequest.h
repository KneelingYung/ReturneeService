//
//  NetRequest.h


//  Copyright (c) 2015年 xueAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequest : NSObject

//GET请求
/**
 *  GET请求
 *
 *  @param url        接口地址
 *  @param parameters 参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject)) success failure:(void(^)(NSError *error)) failure;


//POST请求
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject)) success failure:(void(^)(NSError *error)) failure;


//上传认证头像
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id formData))block progress:(void (^)(NSProgress *))UploadProgress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
