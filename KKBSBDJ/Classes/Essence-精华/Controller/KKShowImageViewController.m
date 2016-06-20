//
//  KKShowImageViewController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKShowImageViewController.h"
#import "KKProgressView.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

@interface KKShowImageViewController ()

/** 内容 scrollerView */
@property (weak, nonatomic) IBOutlet UIScrollView *content_scrollView;

/** 进度圈 控件 */
@property (weak, nonatomic) IBOutlet KKProgressView *showProgress_view;

/** dismiss viewController */
- (IBAction)goBack_click:(id)sender;

/** 保存按钮 */
- (IBAction)save_clcik:(UIButton *)sender;

/** img 图片 */
@property (nonatomic, weak) UIImageView *imgView;


@end

@implementation KKShowImageViewController

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(goBack_click:)];
    [imgView addGestureRecognizer:tap];
    
    self.imgView = imgView;
    [self.content_scrollView addSubview:imgView];
    
    [self.view addGestureRecognizer:tap];
    
    // 图片显示出来的宽 高
    CGFloat imgW = screenW;
    CGFloat imgH = screenW * self.word.height / self.word.width;
    
    if (imgH > screenH) {
        imgView.frame = CGRectMake(0, 0, imgW, imgH);
        self.content_scrollView.contentSize = CGSizeMake(0, imgH);
        
    }else{
        imgView.size = CGSizeMake(imgW, imgH);
        imgView.centerY = screenH * .5;
    }
    
    // 显示下载进度
    [self.showProgress_view setProgress:self.word.progressNumber];
    
    // 下载图片
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.word.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.showProgress_view.hidden = NO;
        CGFloat proNumber = 1.0 * receivedSize / expectedSize;
        [self.showProgress_view setProgress:proNumber];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.showProgress_view.hidden = YES;
    }];
    
}

- (IBAction)goBack_click:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save_clcik:(UIButton *)sender {
    if (self.imgView.image==nil) {
        [SVProgressHUD showWithStatus:@"正在努力加载中..."];
        return;
    }
    
    // 将图片写入到相册
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
@end
