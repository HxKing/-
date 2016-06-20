//
//  KKWord.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/26.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKWord : NSObject
/** 帖子的id */
@property (nonatomic, copy) NSString *ID;
/** string	最大的帖子id */
@property (nonatomic, copy) NSString *maxid;
/** string	头像的图片url地址 */
@property (nonatomic, copy) NSString *profile_image;
/** string	收藏量 */
@property (nonatomic, copy) NSString *love;
/** string	每次加载下一页的时候，需要传入上一页返回参数中对应的此内容，例如：1434112682 */
@property (nonatomic, copy) NSString *maxtime;
/** string	发帖人的昵称 */
@property (nonatomic, copy) NSString *name;
/** string	系统审核通过后创建帖子的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** int	是否是新浪会员 */
@property (nonatomic, assign) NSInteger sina_v;
/** string	踩的人数 */
@property (nonatomic, copy) NSString *cai;
/** string	转发的数量 */
@property (nonatomic, copy) NSString *repost;
/** string	帖子的被评论数量 */
@property (nonatomic, copy) NSString *comment;
/** string	帖子的被ding数量 */
@property (nonatomic, copy) NSString *ding;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, assign) KKTopicType type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 视频的时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频的播放次数 */
@property (nonatomic, assign) NSInteger playfcount;
/** 最热评论(期望这个数组中存放的是XMGComment模型) */
@property (nonatomic, strong) NSArray *top_cmt;

/**** 辅助属性 ****/

/** cell 的行高 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** cell 上cententImg的 frame */
@property (nonatomic, assign, readonly) CGRect picureF;
/** cell 上音乐背景图片的 frame */
@property (nonatomic, assign, readonly) CGRect voiceF;
/** cell 上视频的 frame */
@property (nonatomic, assign, readonly) CGRect videoF;
/** cell 图片是否是 大图 */
@property (nonatomic, assign, getter=isToBigImg) BOOL isToBigImg;
/** cell 图片 下载进度 */
@property (nonatomic, assign) CGFloat progressNumber ;

@end
