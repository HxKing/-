//
//  KKVoiceView.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/6.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKVoiceView.h"
#import "UIImageView+WebCache.h"

@interface KKVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *voiceImg;
@property (weak, nonatomic) IBOutlet UILabel *playNumber;

@property (weak, nonatomic) IBOutlet UILabel *playTime;


@end

@implementation KKVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (void)setWord:(KKWord *)word{
    _word = word;
    
    [self.voiceImg sd_setImageWithURL:[NSURL URLWithString:word.large_image]];
    int h = (int)word.voicetime/60;
    int s = word.voicetime%60;
    self.playTime.text = [NSString stringWithFormat:@"%02zd:%02zd",h,s];
    self.playNumber.text = [NSString stringWithFormat:@"播放%ld次",word.playcount];
    
    
}
@end
