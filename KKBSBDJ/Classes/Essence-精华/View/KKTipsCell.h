//
//  KKTipsCell.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/26.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKWord;

@interface KKTipsCell : UITableViewCell

+ (instancetype)cell;

/** 模型对像 */
@property (nonatomic, strong) KKWord *word;

@end
