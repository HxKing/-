//
//  KKNewPictureView.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/13.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKNewPictureView.h"

@implementation KKNewPictureView


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIcon" target:self action:@selector(newClick)];
    
}

- (void)newClick{
    KKFunc;
}

@end
