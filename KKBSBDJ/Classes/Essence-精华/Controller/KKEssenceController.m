//
//  KKEssenceController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/18.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKEssenceController.h"
#import "KKRecomTagsViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "KKTitleBtn.h"
#import "KKTopicViewController.h"

@interface KKEssenceController ()<UIScrollViewDelegate,KKTitleBtnDelegate>
/** nav 下面的 btn*/
@property (nonatomic, weak) UIButton *titleBtn;

/** 状态指示view   nav 下面的 btn的状态指示view */
@property (nonatomic, weak) UIView *indicatorView;

/** 内容scrollerView */
@property (nonatomic, weak) UIScrollView *contentScrollView;

// nav下面的 bar （view）
@property (nonatomic, weak) KKTitleBtn *titleView;

@end

@implementation KKEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化nav
    [self setupVcInit];
    
    // 初始化内容view
    [self addChildVC];
    
    // 设置nav下面的bar
    [self setupHeadBar];
    
    // 设置contentview
    [self setupContentView];
    
}

- (void)setupContentView{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    
    self.contentScrollView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)addChildVC{
    
    KKTopicViewController *word = [[KKTopicViewController alloc] init];
    word.title = @"段子";
    word.topictType = KKTopicTypeWord;
    [self addChildViewController:word];
    
    KKTopicViewController *voice = [[KKTopicViewController alloc] init];
    voice.title = @"声音";
    voice.topictType = KKTopicTypeVoice;
    [self addChildViewController:voice];
    
    KKTopicViewController *video = [[KKTopicViewController alloc] init];
    video.title = @"视频";
    video.topictType = KKTopicTypeVideo;
    [self addChildViewController:video];

    KKTopicViewController *pic = [[KKTopicViewController alloc] init];
    pic.title = @"图片";
    pic.topictType = KKTopicTypePicture;
    [self addChildViewController:pic];
    
    KKTopicViewController *all = [[KKTopicViewController alloc] init];
    all.title = @"全部";
    all.topictType = KKTopicTypeAll;
    [self addChildViewController:all];
    
}

- (void)titleBtn:(KKTitleBtn *)titleBtnBar index:(NSInteger)index{
    
    CGPoint contentOffset = self.contentScrollView.contentOffset;
    contentOffset.x = self.view.width * index;
    [self.contentScrollView setContentOffset:contentOffset animated:YES];
    
}

// 设置nav下面的bar
- (void)setupHeadBar
{
    KKTitleBtn *titleBar = [[KKTitleBtn alloc] init];
    titleBar.frame = CGRectMake(0, KKTitleViewY, self.view.width, KKTitleViewH);
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (UIViewController *vc in self.childViewControllers) {
        [tempArray addObject:vc.title];
    }
    
    titleBar.titleArray = tempArray;
    titleBar.titleBarDelegate = self;
    self.titleView = titleBar;
    
    [self.view addSubview:titleBar];
}

// 初始化nav
- (void)setupVcInit
{
    self.view.backgroundColor = KKGlobalBg;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick" target:self action:@selector(mainClick)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)mainClick{

    KKRecomTagsViewController *tags = [[KKRecomTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
    
}


#pragma make - scrollerView

// scrollerView 在滚动的时候会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
//    KKFunc;
}

// scrollerView 滚动完（动画结束）之后调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [self.contentScrollView addSubview:vc.view];
    
}

// 减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / self.view.width;

    [self.titleView clickBtn:index];

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
