//
//  KKHttpTool.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/22.
//  Copyright © 2016年 王亚康. All rights reserved.
//  负责整个工程中的所有http请求

#import <Foundation/Foundation.h>



@interface KKHttpTool : NSObject

/**
 *  发送一个get请求
 *
 *  @param url     地址
 *  @param parame  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)get:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id rescut))success failure:(void (^)(NSError *error))failure;


+ (void)post:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id rescut))success failure:(void (^)(NSError *error))failure;

/**
 *  取消所有的网络请求
 */
+ (void)stopAllRequest;

@end
