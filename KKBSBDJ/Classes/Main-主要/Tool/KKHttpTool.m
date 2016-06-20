//
//  KKHttpTool.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/22.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKHttpTool.h"
#import "AFNetworking.h"

@implementation KKHttpTool

+ (void)get:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

+ (void)post:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}

/**
 *  取消所有的网络请求
 */
+ (void)stopAllRequest{
    
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
    
    
}
@end