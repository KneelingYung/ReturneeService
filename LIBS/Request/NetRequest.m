//
//  NetRequest.m

//  Copyright (c) 2015年 xueAn. All rights reserved.
//

#import "NetRequest.h"
#import "AFNetworking.h"
@implementation NetRequest

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    //初始化请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //超时时间
    manager.requestSerializer.timeoutInterval = 5;
    //设置MIME格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",nil];
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (failure) {
            failure(error);
        }
        

    }];
    
    

    
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //初始化请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //超时时间
    manager.requestSerializer.timeoutInterval = 5;
    //设置MIME格式
     
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",nil];
    
   ;
    
    
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}


+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id  formData))block progress:(void (^)(NSProgress *))UploadProgress success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    //初始化请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //超时时间
    manager.requestSerializer.timeoutInterval = 5;
    //设置MIME格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",nil];
    
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        block(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        UploadProgress(uploadProgress);
  
        NSLog(@"%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        NSLog(@"%@",error);
    }];


}
@end


