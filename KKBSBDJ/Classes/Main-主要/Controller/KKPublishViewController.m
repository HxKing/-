//
//  KKPublishViewController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/4.
//  Copyright © 2016年 王亚康. All rights reserved.
//


#import "KKPublishViewController.h"
#import "KKVerticalButton.h"
#import <pop/POP.h>

@interface KKPublishViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cancalClick;
@end

@implementation KKPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cancalClick.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    
    CGFloat btnW = 70;
    CGFloat btnH = btnW + 30;

    int startX = 15;
    int startY = (HEIGHT - btnH *2)/2.0;
   
    CGFloat xMargin = (WIDTH - 2*startX - maxCols*btnW)/(maxCols - 1);
    
    for (int i = 0 ; i<images.count; i++) {
        
        KKVerticalButton *btn = [[KKVerticalButton alloc] init];
        [self.view addSubview:btn];
        
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        CGFloat btnX = startX + (i % 3) * (btnW + xMargin);
        CGFloat btnEndY = startY + (i / 3) * (btnH + 20);
        
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        springAnimation.springSpeed = 5;
        springAnimation.springBounciness = 1;
        
        springAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY - HEIGHT, btnW, btnH)];
        
        springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
        
        springAnimation.beginTime = CACurrentMediaTime() + (0.6-(i*0.1))/2.0;
        
        if (i==1 || i==5) {
            springAnimation.beginTime = CACurrentMediaTime();
        }
        
        [btn pop_addAnimation:springAnimation forKey:nil];
        
    }
    

    
    UIImageView *titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:titleImg];
    
    CGFloat titleX = WIDTH *0.5;

    CGFloat titleBeginY = HEIGHT*0.18 - HEIGHT;
    CGFloat titleEndY = HEIGHT * 0.18;
    
    POPSpringAnimation *titleAnimain = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    titleAnimain.fromValue = [NSValue valueWithCGPoint:CGPointMake(titleX,titleBeginY)];
    titleAnimain.toValue = [NSValue valueWithCGPoint:CGPointMake(titleX,titleEndY)];
    
    titleAnimain.beginTime = CACurrentMediaTime() + 5 * 0.1/2;
    
    [titleAnimain setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.cancalClick.userInteractionEnabled = YES;
    }];
    
    [titleImg pop_addAnimation:titleAnimain forKey:nil];
    
    
}

- (IBAction)concleBtn:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    
    NSArray *subs = self.view.subviews;
    for (int i = 2; i<subs.count-1; i++) {
        
        UIView *v = (UIView *)subs[i];
        CGRect rect = v.frame;
        
        POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(rect.origin.x,  HEIGHT+ rect.origin.y , rect.size.height, rect.size.width)];
        
        basicAnimation.beginTime = CACurrentMediaTime() + 0.05 * i;
        
        [v pop_addAnimation:basicAnimation forKey:nil];

    }
    
    UIView *lastView = [subs lastObject];
    
    POPBasicAnimation *bas = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    bas.toValue = [NSValue valueWithCGPoint:CGPointMake(lastView.frame.origin.x, HEIGHT + lastView.frame.origin.y)];
    bas.beginTime = CACurrentMediaTime() + 7 * 0.05;
    
    [bas setCompletionBlock:^(POPAnimation *anim, BOOL f) {
        
        [self dismissViewControllerAnimated:nil completion:nil];
    }];
    
    [lastView pop_addAnimation:bas forKey:nil];
    
}

@end
