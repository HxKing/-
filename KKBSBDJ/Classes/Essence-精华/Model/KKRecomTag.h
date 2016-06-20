//
//  KKRecomTag.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/24.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKRecomTag : NSObject

/** 头像路径 */
@property (nonatomic, copy) NSString *image_list;

/** 名称 */
@property (nonatomic, copy) NSString *theme_name;

/** 关注数 */
@property (nonatomic, assign) NSNumber *sub_number;



@end
