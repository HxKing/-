//
//  KKPictureView.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/28.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKWord.h"

@interface KKPictureView : UIView

+ (instancetype)pictureView;

/** mode object */
@property (nonatomic, strong) KKWord *word;

@end
