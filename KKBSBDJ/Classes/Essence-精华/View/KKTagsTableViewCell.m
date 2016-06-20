//
//  KKTagsTableViewCell.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/24.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKTagsTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface KKTagsTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *fansNumber;
@end

@implementation KKTagsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecomTag:(KKRecomTag *)recomTag{
    _recomTag = recomTag;
    
//    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:recomTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.headerImg setHeader:recomTag.image_list];
    
    self.userName.text = recomTag.theme_name;
    
    
    NSString *fansNum = nil;
    int fans = [recomTag.sub_number intValue];
    KKLog(@"%d",fans);
    if (fans < 10000) {
        fansNum = [NSString stringWithFormat:@"%d人订阅",fans];
    }else{
        fansNum = [NSString stringWithFormat:@"%.1f万人订阅",fans/10000.0];
    }
    
    self.fansNumber.text = fansNum;
}

- (void)setFrame:(CGRect)frame{
    
    frame.origin.x = 10;

    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= 1;

    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
