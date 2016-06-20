//
//  KKRecommendUser.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/23.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKRecommendUser : NSObject

/** uid */
@property (nonatomic, assign) NSNumber *uid;

/** 头像图片路径 */
@property (nonatomic, copy) NSString *header;

/** name */
@property (nonatomic, copy) NSString *screen_name;

/** 粉丝数 */
@property (nonatomic, assign) NSNumber *fans_count;

@end
