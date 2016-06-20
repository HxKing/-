//
//  KKRecommendViewController.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/2/22.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKRecommendViewController.h"
#import "SVProgressHUD.h"
#import "KKHttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "KKRecom.h"
#import "KKRecommendUser.h"
#import "KKRecommendCateoryCell.h"
#import "KKRecommendUserCell.h"
#import "AFNetworking.h"

@interface KKRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 左侧 类别的tableView */
@property (weak, nonatomic) IBOutlet UITableView *categorieTavbleView;

/** 右侧 user的tableView */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *parame;

/** 推荐关注左侧列表数据源 */
@property (nonatomic, strong) NSArray *categories;


@end

@implementation KKRecommendViewController

static NSString * const categoriesID = @"categorie";
static NSString * const userCellID = @"user";

- (NSMutableDictionary *)parame{
    if (!_parame) {
        _parame = [[NSMutableDictionary alloc] init];
    }
    return _parame;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启ios右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRrefesh];
    
    // 加载左侧数据
    [self setUpLeftData];
    
}

// 加载左侧数据
- (void)setUpLeftData{
    
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"category";
    parame[@"c"] = @"subscribe";
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        
        [SVProgressHUD dismiss];
        
        self.categories = [KKRecom mj_objectArrayWithKeyValuesArray:rescut[@"list"]];
        
        [self.categorieTavbleView reloadData];
        
        // 滚动至首个
        [self.categorieTavbleView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSError *error) {
        
//        [SVProgressHUD dismiss];
        // 友好提示
        [SVProgressHUD showErrorWithStatus:@"网络加载出错"];
    }];
}

// 添加刷新控件
- (void)setupRrefesh{
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
}

// 下拉刷新
- (void)loadNewUsers{
    
    KKRecom *recom = self.categories[self.categorieTavbleView.indexPathForSelectedRow.row];

    recom.currentPage = 1;
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"subscribe";
    parame[@"category_id"] = recom.id;
    self.parame = parame;
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        // 清空数据源
        [recom.users removeAllObjects];
        
        // 保存用户总数
        recom.total = rescut[@"total"];
        
        // 获取某一个频道的用户
        NSArray *users = [KKRecommendUser mj_objectArrayWithKeyValuesArray:rescut[@"list"]];
        
        // 对应频道，添加相应用户
        [recom.users addObjectsFromArray:users];
        
        // 不是最后一次数据
        if (parame != self.parame) return ;
        
        // 展示数据
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 检测有没有 更多数据
        [self checkFooterState];
        
    } failure:^(NSError *error) {
         if (parame != self.parame) return ;
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 友好提示
        [SVProgressHUD showErrorWithStatus:@"网络加载出错"];
    }];
    
}


// 上拉加载更多
- (void)loadMoreUsers{
    
    KKRecom *recom = self.categories[self.categorieTavbleView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"subscribe";
    parame[@"category_id"] = [recom id];
    parame[@"page"] = @(++recom.currentPage);
    self.parame = parame;
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        // 获取某一个频道的用户(字典数组－－>模型数组)
        NSArray *users = [KKRecommendUser mj_objectArrayWithKeyValuesArray:rescut[@"list"]];
        
        // 对应频道，添加相应用户
        [recom.users addObjectsFromArray:users];
        
        // 不是最后一次，数据
        if (parame != self.parame) return ;
        
        // 展示数据
        [self.userTableView reloadData];
        
        // 结束刷新
        [self checkFooterState];
        
    } failure:^(NSError *error) {
        
        if (parame != self.parame) return ;
        
        [self.userTableView.mj_footer endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
}

// 时刻监测footerView的状态
- (void)checkFooterState{
    KKRecom *recom = self.categories[self.categorieTavbleView.indexPathForSelectedRow.row];
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (recom.users.count == 0);
    
    // 让底部控件结束刷新
    if ([recom.total integerValue] == recom.users.count) {// 全部数据已经加载完毕
        
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}

// 设置tableView
- (void)setupTableView{
    
    [self.categorieTavbleView registerNib:[UINib nibWithNibName:NSStringFromClass([KKRecommendCateoryCell class]) bundle:nil] forCellReuseIdentifier:categoriesID];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userCellID];
    
//    self.userTableView.backgroundColor = KKGlobalBg
    
    // 设置 ScrollView 相对于nav的位置，默认64个高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置边距
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categorieTavbleView.contentInset = self.userTableView.contentInset;
    
    self.userTableView.rowHeight = 70;
    
    self.categorieTavbleView.tableFooterView = [[UIView alloc] init];
//    self.userTableView.tableFooterView = [[UIView alloc] init];
    
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = KKGlobalBg;
    
}


#pragma mark - table View data

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categorieTavbleView) {
        return self.categories.count;
    }else{
        
       KKRecom *recom = self.categories[self.categorieTavbleView.indexPathForSelectedRow.row];
        
        // 监测footer的状态
        [self checkFooterState];
        
        return recom.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categorieTavbleView) {
        
        KKRecommendCateoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoriesID];
        
        cell.recom = self.categories[indexPath.row];
        
        return cell;
    }else{
        
        KKRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellID];
        
       KKRecom *recom = self.categories[self.categorieTavbleView.indexPathForSelectedRow.row];
       
        cell.reocmUser = recom.users[indexPath.row];
        
        return cell;
    }
    
}

#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.userTableView){
        
        
    }else{
        
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        
        KKRecom *recom = self.categories[indexPath.row];
        
        if (recom.users.count) {
            // 显示曾经的数据
            [self.userTableView reloadData];
        }else{
            // 不让用户看到，上次的残留数据
            [self.userTableView reloadData];
            
            // 马上进入刷新状态
            [self.userTableView.mj_header beginRefreshing];
            
        }
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)dealloc{
//    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
//    [manger.operationQueue cancelAllOperations];

    [KKHttpTool stopAllRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
