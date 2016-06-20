//
//  KKTitleBtn.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/26.
//  Copyright © 2016年 王亚康. All rights reserved.
//

// item 的宽度
#define BTNWIDTH                    self.width/5
// item 的 字体颜色 （Normal）
#define NORMAL_FONT_COLOR           [UIColor grayColor]
// item 的 字体颜色 （点击后）
#define DISABLED_FONT_COLOR         [UIColor redColor]
// item 的 字体大小
#define FONT                        [UIFont systemFontOfSize:14]
// bar 的背景颜色
#define BAR_BACKGROUND_COLOR        [UIColor colorWithWhite:1 alpha:0.5]


#import "KKTitleBtn.h"

@interface KKTitleBtn()

/** nav 下面的 btn*/
@property (nonatomic, weak) UIButton *titleBtn;

/** 状态指示view   nav 下面的 btn的状态指示view */
@property (nonatomic, weak) UIView *indicatorView;


@end


@implementation KKTitleBtn

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    [self createItems:titleArray];
    
    self.contentSize = CGSizeMake(titleArray.count * BTNWIDTH, self.height);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;        
    }
    return self;
}

- (instancetype)initWithTitleArray:(NSArray *)titleArr{
    
    [self createItems:titleArr];
    
    return self;
    
}

- (void)createItems:(NSArray *)titleArr{
    
    NSInteger titleCount = titleArr.count;
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = DISABLED_FONT_COLOR;
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    for (int i = 0 ; i<titleCount; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+i;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:NORMAL_FONT_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:DISABLED_FONT_COLOR forState:UIControlStateDisabled];
        btn.titleLabel.font = FONT;
        [btn addTarget:self action:@selector(navbuttomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
    
    self.backgroundColor = BAR_BACKGROUND_COLOR;
    
}

- (void)clickBtn:(NSInteger)index{
    
    UIButton *button = self.subviews[index+1];
    self.titleBtn.enabled = YES;
    self.titleBtn = button;
    button.enabled = NO;
    
//    [self navbuttomBtnClick:self.subviews[index]];
    [UIView animateWithDuration:.25 animations:^{
        
        // 一定要先有width 然后再去 计算centerx，不然会出错。
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
}

- (void)navbuttomBtnClick:(UIButton *)button{
    
    // 1.改变上次点击的按钮 的状态
    self.titleBtn.enabled = YES;
    // 2.保存本次点击的按钮
    self.titleBtn = button;
    // 3.设置本次点击的按钮
    button.enabled = NO;
    
    [UIView animateWithDuration:.25 animations:^{
        
        // 一定要先有width 然后再去 计算centerx，不然会出错。
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    
    if ([self.titleBarDelegate respondsToSelector:@selector(titleBtn:index:)]) {
        [self.titleBarDelegate titleBtn:self index:(button.tag - 100)];
    }
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置item的frame
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:[UIButton class]]) continue;
        
        [self setupFrame:(UIButton *)view with:view.tag];
    }
    
    // 设置indicatorView的frame
    self.indicatorView.height = 2;
    self.indicatorView.y = self.height - self.indicatorView.height;
}


- (void)setupFrame:(UIButton *)btn with:(NSInteger)tag{
    
    tag -= 100;
    btn.width = BTNWIDTH;
    btn.height = self.height;
    
    btn.x =  tag * btn.width;
    
    if (tag == 0) {
        self.indicatorView.width = btn.titleLabel.width;
        self.indicatorView.centerX = btn.centerX;
    }
}





@end
