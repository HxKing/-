//
//  KKRecommendCateoryCell.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/22.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKRecommendCateoryCell.h"


@interface KKRecommendCateoryCell()





/** cell 左侧选中的表示 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end


@implementation KKRecommendCateoryCell

- (void)awakeFromNib {
    
//    self.backgroundColor = KKGlobalBg;
    
//    self.textLabel.highlightedTextColor = KKRGBColor(219, 21, 26);
    

    self.selectedIndicator.hidden = YES;
}


- (void)layoutSubviews{
    [super layoutSubviews];

    self.textLabel.font = [UIFont systemFontOfSize:13.0f];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
    
    
}

- (void)setRecom:(KKRecom *)recom{
    _recom = recom;
    
    self.textLabel.text = recom.name;
    
}

// 在这个方法中监听cell 的选中 和取消
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : KKRGBColor(78, 78, 78) ;
    

}

@end
