//
//  KKRecommendUserCell.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/23.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKRecommendUserCell.h"
#import "UIImageView+WebCache.h"

@interface KKRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImg;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *userFans;
@end


@implementation KKRecommendUserCell

- (void)awakeFromNib {
    self.userHeaderImg.layer.cornerRadius = self.userHeaderImg.width * .5;
    self.userHeaderImg.layer.masksToBounds = YES;
}


- (void)setReocmUser:(KKRecommendUser *)reocmUser{
    
    _reocmUser = reocmUser;
    
//    [self.userHeaderImg sd_setImageWithURL:[NSURL URLWithString:reocmUser.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.userHeaderImg setHeader:reocmUser.header];
    
    self.userName.text = reocmUser.screen_name;
    
    self.userFans.text = reocmUser.fans_count.stringValue;
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
