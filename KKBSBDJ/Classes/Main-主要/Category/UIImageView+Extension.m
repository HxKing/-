//
//  UIImageView+Extension.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/13.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+KKExtension.h"

@implementation UIImageView (Extension)

- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}

@end
