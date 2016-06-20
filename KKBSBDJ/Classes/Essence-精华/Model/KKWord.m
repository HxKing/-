//
//  KKWord.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/26.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKWord.h"
#import "NSDate+XMGExtension.h"
#import "MJExtension.h"
#import "KKComment.h"
#import "KKUser.h"

@implementation KKWord{
    CGFloat _cellHeight;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"top_cmt" : @"KKComment"
             };
}

- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_created_at];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

- (CGFloat)cellHeight{
    
    if (!_cellHeight) {
        
        // 文字的最大size
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT);

        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin;

        
        // 文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize
                                                options:options
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                context:nil].size.height;
//
        // cell 文字lable的高度
         _cellHeight = textH + KKTopicCellTextMinY + KKTopicCellMargin;
        
        if (self.type == KKTopicTypePicture) {
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= 700) {
                _isToBigImg = YES;
                pictureH = 250;
            }else{
                _isToBigImg = NO;
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = KKTopicCellMargin;
            CGFloat pictureY = KKTopicCellTextMinY + textH + KKTopicCellMargin;
            _picureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + KKTopicCellMargin;
        }else if (self.type == KKTopicTypeVoice){
            // 图片显示出来的宽度
            CGFloat voiceW = maxSize.width;
            // 显示显示出来的高度
            CGFloat voiceH = voiceW * self.height / self.width;
            // 计算图片控件的frame
            CGFloat voiceX = KKTopicCellMargin;
            CGFloat voiceY = KKTopicCellTextMinY + textH + KKTopicCellMargin;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + KKTopicCellMargin;
            
        } else if(self.type == KKTopicTypeVideo){
            
            // 图片显示出来的宽度
            CGFloat voiceW = maxSize.width;
            // 显示显示出来的高度
            CGFloat voiceH = voiceW * self.height / self.width;
            // 计算图片控件的frame
            CGFloat voiceX = KKTopicCellMargin;
            CGFloat voiceY = KKTopicCellTextMinY + textH + KKTopicCellMargin;
            _videoF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + KKTopicCellMargin;
        }
        
        KKComment *cmt = [self.top_cmt firstObject];
        if (cmt) {
            
             NSString *content = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
            CGFloat cmtH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            
            _cellHeight += cmtH + KKCommentTitleH + KKTopicCellMargin;
        }
        
        
        _cellHeight += KKTopicCellBottomBarH + KKTopicCellMargin;
    }
    
    return _cellHeight;
}





@end
