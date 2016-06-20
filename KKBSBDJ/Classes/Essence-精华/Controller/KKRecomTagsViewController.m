//
//  KKRecomTagsViewController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/24.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKRecomTagsViewController.h"
#import "KKHttpTool.h"
#import "MJExtension.h"
#import "KKRecomTag.h"
#import "KKTagsTableViewCell.h"
#import "SVProgressHUD.h"

@interface KKRecomTagsViewController ()

/** 模型数组 */
@property (nonatomic, strong) NSArray *tagsArray;

@end

@implementation KKRecomTagsViewController

static NSString * const tagCellID = @"tagCell";

- (NSArray *)tagsArray{
    if (!_tagsArray) {
        _tagsArray = [[NSArray alloc] init];
    }
    return _tagsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tabView
    [self setupTabView];
    
    // 加载网络数据
    [self getNetDate];
    
}
// 加载网络数据
- (void)getNetDate{
    [SVProgressHUD show];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"tag_recommend";
    parame[@"action"] = @"sub";
    parame[@"c"] = @"topic";
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        
        [SVProgressHUD dismiss];
        
        // 字典数组 --> 模型数组
        self.tagsArray = [KKRecomTag mj_objectArrayWithKeyValuesArray:rescut];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络加载出错"];
    }];
}

// 设置tabView
- (void)setupTabView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKTagsTableViewCell class]) bundle:nil] forCellReuseIdentifier:tagCellID];
    
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = KKGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - tableView data

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tagsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKTagsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
    
    cell.recomTag = self.tagsArray[indexPath.row];
    
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
}

- (void)dealloc{
    
    [KKHttpTool stopAllRequest];
}


@end
