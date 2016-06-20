//
//  KKTabBar.m
//  kkTj
//
//  Created by 王亚康 on 16/2/16.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKTabBar.h"
#import "UIView+Extension.h"

@interface KKTabBar()

@property (nonatomic, weak) UIButton *plusButton;


@end

@implementation KKTabBar



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // 添加加号按钮
        [self setPlusButton];
    }
    return self;
}

// 添加加号按钮
- (void)setPlusButton
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(clickPlus:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    self.plusButton = btn;
    
}

- (void)clickPlus:(UIButton *)sender{
    
    // 通知代理
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidPlusClick:)]) {
        [self.tabBarDelegate tabBarDidPlusClick:self];
    }
    
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置plusButton的frame
    [self setupPlusButtonFrame];
    
    // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
}

/**
 *  设置所有plusButton的frame
 */
- (void)setupPlusButtonFrame
{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * .5, self.height * .5);
}

/**
 *  设置所有tabbarButton的frame
 */
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    if (index >= 2) {
        tabBarButton.x = buttonW * (index + 1);
    } else {
        tabBarButton.x = buttonW * index;
    }
    tabBarButton.y = 0;
}

@end
