//
//  KKTopWindoe.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/13.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKTopWindoe.h"

@implementation KKTopWindoe

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, WIDTH, 50);
    window_.windowLevel = UIWindowLevelNormal;
    window_.rootViewController = [[UIViewController alloc] init];
//    window_.alpha = 0;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}



+ (void)show
{
    window_.hidden = NO;
//    [window_ makeKeyAndVisible];
}

+ (void)hide
{
    window_.hidden = YES;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}



@end
