//
//  KKVideoView.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/6.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKVideoView.h"
#import "UIImageView+WebCache.h"

@interface KKVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *videoImg;

@property (weak, nonatomic) IBOutlet UILabel *videoNumber;

@property (weak, nonatomic) IBOutlet UILabel *videoTime;
@end

@implementation KKVideoView

+ (instancetype)videoView{
    
   return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

- (void)setWord:(KKWord *)word{
    _word = word;
    
    [self.videoImg sd_setImageWithURL:[NSURL URLWithString:word.large_image]];
    
    self.videoNumber.text = [NSString stringWithFormat:@"播放%ld次",word.playcount];
    int h = (int)word.videotime/60;
    int s = word.videotime%60;
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd",h,s];
    
}

@end
