//
//  KKUser.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/7.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
