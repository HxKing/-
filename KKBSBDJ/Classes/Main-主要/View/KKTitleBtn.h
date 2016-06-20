//
//  KKTitleBtn.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/26.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKTitleBtn;

@protocol KKTitleBtnDelegate <NSObject>

- (void)titleBtn:(KKTitleBtn *)titleBtnBar index:(NSInteger)index;

@end

@interface KKTitleBtn : UIScrollView

/** titleBtnBar 上 item 显示内容 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak) id<KKTitleBtnDelegate> titleBarDelegate;

- (void)clickBtn:(NSInteger)index;

@end
