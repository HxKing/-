//
//  KKVideoView.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/6.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKWord.h"


@interface KKVideoView : UIView
+ (instancetype)videoView;

/** model object */
@property (nonatomic, strong) KKWord *word;

@end
