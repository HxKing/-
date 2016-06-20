//
//  KKLoginRegistTF.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/25.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKLoginRegistTF.h"


@implementation KKLoginRegistTF

//+ (void)initialize{
//
//   unsigned int num = 0;
//    Ivar *ivars = class_copyIvarList([UITextField class], &num);
//    for (int i=0; i<num; i++) {
//        Ivar ivar = *(ivars+i);
//        KKLog(@"%s",ivar_getName(ivar));
//    }
//    free(ivars);
//}

- (void)awakeFromNib{
    
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.tintColor = self.textColor;
}

// 获取第一响应者
- (BOOL)becomeFirstResponder{
    
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

// 失去第一响应者
- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

// 光标聚焦时会调用
//- (void)setHighlighted:(BOOL)highlighted{
//    NSLog(@"%d",highlighted);
//}


@end
