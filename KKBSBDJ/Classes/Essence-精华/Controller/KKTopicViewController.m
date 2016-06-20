//
//  KKTopicViewController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/26.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKTopicViewController.h"
#import "KKHttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "KKWord.h"
#import "KKTipsCell.h"
#import "SVProgressHUD.h"
#import "KKCommentVC.h"
#import "KKNewPictureView.h"

@interface KKTopicViewController ()

/** dataArray */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 当前页码 */
@property (nonatomic, assign) NSInteger crruePage;

/** 最大页码数 */
@property (nonatomic, copy) NSString *maxtime;

/** 请求参数，处理网络请求，确保是最后一次 */
@property (nonatomic, strong) NSDictionary *parame;

@end

@implementation KKTopicViewController

static NSString * const tipsCell = @"tipsCell";

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
// 一定要先有tableView 再去添加刷新控件，不然，会有小问题。（上拉刷新tableView整体回向下掉）
    [self setupTableView];

    [self setupRefresh];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = KKGlobalBg;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKTipsCell class]) bundle:nil] forCellReuseIdentifier:tipsCell];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = KKTitleViewY + KKTitleViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsTopics)];
//    设置下啦刷新程度，设置 透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

- (NSString *)a{
    return [self.parentViewController isKindOfClass:[KKNewPictureView class]] ? @"newlist" : @"list";
}

- (void)loadNewsTopics{
    
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = self.a;
    parame[@"c"] = @"data";
    parame[@"type"] = @(self.topictType);
    self.parame = parame;
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        
        if (self.parame != parame) return ;
        
        self.maxtime = rescut[@"info"][@"maxtime"];
        
        self.dataArray = [KKWord mj_objectArrayWithKeyValuesArray:rescut[@"list"]];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 清空页码
        self.crruePage = 0;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        if (self.parame != parame) return ;
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];
    
}

- (void)loadMoreTopics{
    
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = self.a;
    parame[@"c"] = @"data";
    parame[@"type"] = @(self.topictType);
    NSInteger page = self.crruePage + 1;
    parame[@"page"] = @(page);
    parame[@"maxtime"] = self.maxtime;
    self.parame = parame;
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        
        if (self.parame != parame) return ;
        
        // 记录id最大的帖子
        self.maxtime = rescut[@"info"][@"maxtime"];
        
        // 字典 --> 模型
        NSArray *temp = [KKWord mj_objectArrayWithKeyValuesArray:rescut[@"list"]];
        
        // 添加到数据源数组中
        [self.dataArray addObjectsFromArray:temp];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 记录页码
        self.crruePage = page;
        
        // 展示数据
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        if (self.parame != parame) return ;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];

    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.tableView.mj_footer.hidden = (!self.dataArray.count);
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KKTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:tipsCell];
    
    cell.word = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKWord *word = self.dataArray[indexPath.row];
    
    return word.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKCommentVC *comVc = [[KKCommentVC alloc] init];
    
    comVc.word = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:comVc animated:YES];
    
}

@end
