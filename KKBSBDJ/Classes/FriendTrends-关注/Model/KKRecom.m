//
//  KKRecom.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/22.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKRecom.h"

@implementation KKRecom

- (NSMutableArray *)users{
    if (!_users) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

@end
