//
//  KKConst.h
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/27.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KKTopicTypeAll = 1,
    KKTopicTypePicture = 10,
    KKTopicTypeWord = 29,
    KKTopicTypeVoice = 31,
    KKTopicTypeVideo = 41
} KKTopicType;

/** home 页面 nav 下titleView 的高度 */
UIKIT_EXTERN CGFloat const KKTitleViewH ;

/** home 页面 nav 的最大Y值  */
UIKIT_EXTERN CGFloat const KKTitleViewY ;

/** cell 之间的间距 */
UIKIT_EXTERN CGFloat const KKTopicCellMargin ;

/** cell 文字lable的最小Y值 */
UIKIT_EXTERN CGFloat const KKTopicCellTextMinY ;

/** cell BottomBarH */
UIKIT_EXTERN CGFloat const KKTopicCellBottomBarH ;

/** cell 中 “热门评论” 的高度 */
UIKIT_EXTERN CGFloat const KKCommentTitleH ;

/** kkuser 模型中的性别 */
UIKIT_EXTERN NSString * const KKUserSexFemale;
UIKIT_EXTERN NSString * const KKUserSexMale;