//
//  KKTabBarController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/18.
//  Copyright © 2016年 王亚康. All rights reserved.
//


#import "KKTabBarController.h"
#import "KKEssenceController.h"
#import "KKFriendTrendsController.h"
#import "KKNewPictureView.h"
#import "KKTabBar.h"
#import "KKNavController.h"
#import "KKPublishViewController.h"

@interface KKTabBarController ()<KKTabBarDelegate>

@end

@implementation KKTabBarController

/**
 *  类第一次
 */
+ (void)initialize{
    
    // 设置文字的颜色
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor darkTextColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    KKTabBar *tabBar = [[KKTabBar alloc] init];
    tabBar.tabBarDelegate = self;
    // 更换tabBar为自定义的tabBar
    [self setValue:tabBar forKey:@"tabBar"];
 
    // 添加子控制器
    [self setupChildVc];
    
    
}

// 添加子控制器
- (void)setupChildVc{
    
    KKEssenceController *vc01 = [[KKEssenceController alloc ]init];
    [self addChildVc:vc01 title:@"精华" img:@"tabBar_essence_icon" selectImg:@"tabBar_essence_click_icon"];
    
    KKNewPictureView *vc02 = [[KKNewPictureView alloc ]init];
    [self addChildVc:vc02 title:@"新帖" img:@"tabBar_new_icon" selectImg:@"tabBar_new_click_icon"];
    
    KKFriendTrendsController *vc03 = [[KKFriendTrendsController alloc ]init];
    [self addChildVc:vc03 title:@"关注" img:@"tabBar_friendTrends_icon" selectImg:@"tabBar_friendTrends_click_icon"];
    
    UIViewController *vc04 = [[UIViewController alloc ]init];
    [self addChildVc:vc04 title:@"我" img:@"tabBar_me_icon" selectImg:@"tabBar_me_click_icon"];

}

- (void)addChildVc:(UIViewController *)vc title:(NSString *)title img:(NSString *)image selectImg:(NSString *)selectImage
{
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    KKNavController *nav = [[KKNavController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}

#pragma mark - kktabBar deleagte
// 点击中间的按钮调用
- (void)tabBarDidPlusClick:(KKTabBar *)tabBar{
    
    KKPublishViewController *vc = [[KKPublishViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [self presentViewController:vc animated:nil completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
