//
//  KKFriendTrendsController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/18.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKFriendTrendsController.h"
#import "KKRegistLonginController.h"
#import "KKRecommendViewController.h"


@interface KKFriendTrendsController ()

- (IBAction)loginRegistBtn:(UIButton *)sender;

@end

@implementation KKFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KKGlobalBg;
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highImageName:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];

}

- (void)friendClick{
    
   KKRecommendViewController *recommendVc = [[KKRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:recommendVc animated:YES];
    
    
}

- (IBAction)loginRegistBtn:(UIButton *)sender {
    
    KKRegistLonginController *registLoginVc = [[KKRegistLonginController alloc] init];
    [self presentViewController:registLoginVc animated:YES completion:nil];
}
@end
