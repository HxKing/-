//
//  KKVerticalButton.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/24.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKVerticalButton.h"

@implementation KKVerticalButton

- (void)setup{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.frame.size.height - self.imageView.height;
    
}


@end
