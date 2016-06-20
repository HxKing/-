//
//  KKTipsCell.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/26.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKTipsCell.h"
#import "UIImageView+WebCache.h"
#import "KKWord.h"
#import "KKPictureView.h"
#import "KKVoiceView.h"
#import "KKVideoView.h"
#import "KKUser.h"
#import "KKComment.h"

@interface KKTipsCell()
/** 头像 imgview */
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
/** 新浪 加v imgview */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVip_img;
/** 昵称 lb */
@property (weak, nonatomic) IBOutlet UILabel *username_lb;
/** 时间 lb */
@property (weak, nonatomic) IBOutlet UILabel *time_lb;
/** 文字label */
@property (weak, nonatomic) IBOutlet UILabel *text_lb;

/** 右侧 人 的按钮 */
- (IBAction)more_btn:(UIButton *)sender;

/** 顶 按钮 */
@property (weak, nonatomic) IBOutlet UIButton *ding_btn;
/** 踩 按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cai_btn;
/** 转发 按钮 */
@property (weak, nonatomic) IBOutlet UIButton *repost_btn;
/** 评论 按钮 */
@property (weak, nonatomic) IBOutlet UIButton *comment_btn;

/** 图片的内容view */
@property (nonatomic, weak) KKPictureView *pictureView;
/** 声音的内容view */
@property (nonatomic, weak) KKVoiceView *voiceView;
/** 声音的内容view */
@property (nonatomic, weak) KKVideoView *videoView;
@property (weak, nonatomic) IBOutlet UIView *cmtView;
@property (weak, nonatomic) IBOutlet UILabel *cmtContent;

@end

@implementation KKTipsCell

+ (instancetype)cell{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (KKPictureView *)pictureView{
    if (!_pictureView) {
        KKPictureView *picView = [KKPictureView pictureView];
        [self.contentView addSubview:picView];
        _pictureView = picView;
    }
    return _pictureView;
}

- (KKVoiceView *)voiceView{
    if (!_voiceView) {
        KKVoiceView *voice = [KKVoiceView voiceView];
        [self.contentView addSubview:voice];
        _voiceView = voice;
    }
    return _voiceView;
}

- (KKVideoView *)videoView{
    if (!_videoView) {
        KKVideoView *video = [KKVideoView videoView];
        [self.contentView addSubview:video];
        _videoView = video;
    }
    return _videoView;
}



- (void)awakeFromNib {
    
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = self.headImg.width*.5;
    
    UIImageView *cellBj = [[UIImageView alloc] init];
    cellBj.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = cellBj;
        
}

- (void)setWord:(KKWord *)word{
    _word = word;
    self.sinaVip_img.hidden = !word.sina_v;
    
//    [self.headImg sd_setImageWithURL:[NSURL URLWithString:word.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.headImg setHeader:word.profile_image];
    
    self.username_lb.text = word.name;
    self.time_lb.text = word.create_time;
    
    [self setbuttonTitle:self.ding_btn num:word.ding placeholder:@"顶"];
    [self setbuttonTitle:self.cai_btn num:word.cai placeholder:@"踩"];
    [self setbuttonTitle:self.repost_btn num:word.repost placeholder:@"转发"];
    [self setbuttonTitle:self.comment_btn num:word.comment placeholder:@"评论"];
    
    self.text_lb.text = word.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (word.type == KKTopicTypePicture) { // 图片帖子
       
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = NO;
        
        self.pictureView.word = word;
        self.pictureView.frame = word.picureF;
    } else if(word.type == KKTopicTypeVoice){
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        
        self.voiceView.word = word;
        self.voiceView.frame = word.voiceF;
    }else if(word.type == KKTopicTypeVideo){
        
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
        self.videoView.word = word;
        self.videoView.frame = word.videoF;
    }else{
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
    }
    
    KKComment *cmt = [self.word.top_cmt firstObject];
    if (cmt) {
        self.cmtView.hidden = NO;
        NSString *str = [NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
        self.cmtContent.text = str;
        
    }else{
        self.cmtView.hidden = YES;
    }
    
    
}

- (void)setbuttonTitle:(UIButton *)btn num:(NSString *)num placeholder:(NSString *)placeholder
{
    NSInteger count = [num integerValue];
    if (count>10000) {
        placeholder = [NSString stringWithFormat:@"%.1f",count/10000.0];
    }else if(count > 0){
        placeholder = [NSString stringWithFormat:@"%ld",count];
    }
    [btn setTitle:placeholder forState:UIControlStateNormal];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setFrame:(CGRect)frame{
    
//    frame.size.width = WIDTH;
//    frame.size.height -= 10;
    frame.size.height = self.word.cellHeight - KKTopicCellMargin;
    frame.origin.y += KKTopicCellMargin;
    
    [super setFrame:frame];
}

- (IBAction)more_btn:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *op1 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        KKLog(@"你点击 －－ 举报");
    }];
    
    UIAlertAction *op2 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        KKLog(@"你点击 －－ 收藏");
    }];
    
    UIAlertAction *op3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        KKLog(@"你点击 －－ quxiao");
    }];
    
    [alert addAction:op1];
    [alert addAction:op2];
    [alert addAction:op3];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
