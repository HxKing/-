//
//  KKRegistLonginController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/24.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKRegistLonginController.h"

@interface KKRegistLonginController ()

@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (weak, nonatomic) IBOutlet UIView *registView;


@end

@implementation KKRegistLonginController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
- (IBAction)showLoginOrRegist:(UIButton *)sender {
    
//    sender.selected = YES;
    
    KKLog(@"%f",self.registView.x);
    
    [self.view endEditing:YES];
    
    sender.selected = NO;
    
    if (self.centerView.x == 0) {// 现在显示登录
        
        [UIView animateWithDuration: .25 animations:^{
            self.centerView.x = -self.view.width;
            self.registView.x = 0;
        }];
        
        sender.selected = NO;
        
    }else{
        
        [UIView animateWithDuration: .25 animations:^{
            self.centerView.x = 0;
            self.registView.x = self.view.width;
        }];
        sender.selected = YES;
    }
    
}

- (IBAction)dismissBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
