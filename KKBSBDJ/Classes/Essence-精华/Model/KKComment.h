//
//  KKComment.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/7.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KKUser;

@interface KKComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) KKUser *user;

@end
