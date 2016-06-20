//
//  KKProgressView.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKProgressView.h"

@implementation KKProgressView


- (void)awakeFromNib{
    
    self.progressLabel.textColor = [UIColor whiteColor];
    self.roundedCorners = 2;
}

- (void)setProgress:(CGFloat)progress{
    [super setProgress:progress];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

@end
