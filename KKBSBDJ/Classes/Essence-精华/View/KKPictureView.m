//
//  KKPictureView.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/28.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKPictureView.h"
#import "UIImageView+WebCache.h"
#import "KKProgressView.h"
#import "KKShowImageViewController.h"

@interface KKPictureView()

/** 显示大图 btn  */
@property (weak, nonatomic) IBOutlet UIButton *seeBig_btn;
/** gif 标示 imgview  */
@property (weak, nonatomic) IBOutlet UIImageView *gifIcom_img;
/** 内容imgview  */
@property (weak, nonatomic) IBOutlet UIImageView *content_img;
/** 进度圈 view  */
@property (weak, nonatomic) IBOutlet KKProgressView *progress_view;

- (IBAction)seebigImg_click:(id)sender;

@end


@implementation KKPictureView

+ (instancetype)pictureView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(imgViewTap:)];
    self.content_img.userInteractionEnabled = YES;
    [self.content_img addGestureRecognizer:tap];
    
}


- (void)setWord:(KKWord *)word{
    _word = word;
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progress_view setProgress:word.progressNumber];
    
    [self.content_img sd_setImageWithURL:[NSURL URLWithString:word.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progress_view.hidden = NO;
        
        // 计算下载进度
        CGFloat progress = 1.0 * receivedSize/expectedSize;
        word.progressNumber = progress;
        [self.progress_view setProgress:progress];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progress_view.hidden = YES;
    }];
    
    // 判断是否为gif
    NSString *extension = word.large_image.pathExtension;
    self.gifIcom_img.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否为 长图
    if(word.isToBigImg){
        self.seeBig_btn.hidden = NO;
        self.content_img.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBig_btn.hidden = YES;
        self.content_img.contentMode = UIViewContentModeScaleToFill;
    }
    
}

- (void)imgViewTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    KKShowImageViewController *img = [[KKShowImageViewController alloc] init];
    img.word = self.word;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:img animated:YES completion:nil];
    
}

- (IBAction)seebigImg_click:(id)sender {
    
}
@end
