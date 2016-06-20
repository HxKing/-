//
//  KKRecom.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/22.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKRecom : NSObject


/** id */
@property (nonatomic, strong) NSNumber *id;

/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 关注数 count */
@property (nonatomic, strong) NSNumber *count;


/** 添加用户 */
@property (nonatomic, strong) NSMutableArray *users;


/** 用户总数 */
@property (nonatomic, assign) NSNumber *total;

/** 当前页码数 */
@property (nonatomic, assign) NSInteger currentPage;




@end

