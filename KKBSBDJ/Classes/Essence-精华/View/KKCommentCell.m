//
//  KKCommentCell.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/11.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKCommentCell.h"
#import "UIImageView+WebCache.h"
#import "KKUser.h"

@interface KKCommentCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UIImageView *sex_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lb;
@property (weak, nonatomic) IBOutlet UILabel *zan_lb;
@property (weak, nonatomic) IBOutlet UILabel *content_lb;

- (IBAction)zan_btn:(UIButton *)sender;
@end

@implementation KKCommentCell

- (void)awakeFromNib {
//    self.userInteractionEnabled = YES;
//    
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick)]];
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
}

- (void)setCmt:(KKComment *)cmt{
    _cmt = cmt;
    
//    [self.icon_img sd_setImageWithURL:[NSURL URLWithString:cmt.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.icon_img setHeader:cmt.user.profile_image];
    
    self.sex_img.image = [cmt.user.sex isEqualToString:KKUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    
    self.name_lb.text = cmt.user.username;
    self.zan_lb.text = [NSString stringWithFormat:@"%ld",cmt.like_count];
    self.content_lb.text = cmt.content;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)zan_btn:(UIButton *)sender {
}

// 可以获取第一响应者
- (BOOL)canBecomeFirstResponder{
    return YES;
}

// 支持哪些操作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}


@end
