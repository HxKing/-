//
//  KKTabBar.h
//  kkTj
//
//  Created by 王亚康 on 16/2/16.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKTabBar;

@protocol KKTabBarDelegate <NSObject>

- (void)tabBarDidPlusClick:(KKTabBar *)tabBar;

@end

@interface KKTabBar : UITabBar

@property (nonatomic, weak) id<KKTabBarDelegate> tabBarDelegate;

@end
