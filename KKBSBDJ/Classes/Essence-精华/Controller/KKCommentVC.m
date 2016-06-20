//
//  KKCommentVC.m
//  KKBSBDJ
//
//  Created by 王亚康 on 16/3/9.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKCommentVC.h"
#import "KKTipsCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "KKHttpTool.h"
#import "KKComment.h"
#import "KKCommentCell.h"


@interface KKCommentVC ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barButtom;


@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

/** 保存最热评论 */
@property (nonatomic, strong) NSArray *saveHotCmt;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotArray;

/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestArray;

/** 头部view的 高度 */
@property (nonatomic, assign) CGFloat headerHeight;

/** 加载评论 转菊花 */
@property (nonatomic, assign) UIActivityIndicatorView *activiView;

/** 记录当前的页面 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation KKCommentVC

static NSString * const KKCellID = @"cmtid";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // nav 键盘设置
    [self setupBasic];
    
    // 设置头部view
    [self headerView];
    
    // 添加刷新控件
    [self setupRefresh];
    
}
// 设置头部view
- (void)headerView{
    
    UIView *header = [[UIView alloc] init];
    
    header.backgroundColor = KKGlobalBg;
    
    KKTipsCell *cell = [KKTipsCell cell];
    
    // 如果模型对象中，有最热评论，则先保存最热评论。然后，将其至为空。那么他就不会显示了。但是，cellHeight中包含了她的高度，所以，你要再次计算。cell的高度。
    if (self.word.top_cmt.count) {
        self.saveHotCmt = self.word.top_cmt;
        self.word.top_cmt = nil;
        [self.word setValue:@0 forKey:@"cellHeight"];
    }
    
    cell.word = self.word;
    cell.size = CGSizeMake(WIDTH, self.word.cellHeight);
    
    [header addSubview:cell];
    
    header.height = cell.height + 3 * KKTopicCellMargin;
    self.headerHeight = header.height - 64 - 2 * KKTopicCellMargin;
    
    self.contentTableView.tableHeaderView = header;
    
    [self.contentTableView setContentSize:CGSizeMake(WIDTH, header.height+HEIGHT)];
    
}

// 添加刷新控件
- (void)setupRefresh{
    
//    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
//    [self.contentTableView.mj_header beginRefreshing];
    // 取消了 下拉刷新。只需要刷新一次就够了
    [self loadNewComments];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    footerView.size = CGSizeMake(WIDTH, 150);
    
    UIActivityIndicatorView *activiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activiView = activiView;
    
    [footerView addSubview:activiView];
    
    activiView.center = footerView.center;
    
    [activiView startAnimating];
    
    self.contentTableView.tableFooterView = footerView;
    
    // 添加上拉加载更多
    ////////////////////////////////////////////////////////////////
    
    self.contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    self.contentTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载更多
- (void)loadMoreComments{
    // 结束之前的所有请求
    
    NSInteger page = self.page + 1 ;
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.word.ID;
    parame[@"hot"] = @"1";
    parame[@"page"] = @(page);
    KKComment *cmt = [self.latestArray lastObject];
    parame[@"lastcid"] = cmt.ID;
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        
        // 没有数据
        if (![rescut isKindOfClass:[NSDictionary class]]) {
            self.contentTableView.mj_footer.hidden = YES;
            return;
        }

        
        NSArray *temp = [KKComment mj_objectArrayWithKeyValuesArray:rescut[@"data"]];
        
        [self.latestArray addObjectsFromArray:temp];
        
        self.page = page;
        
        [self.contentTableView reloadData];
        
        NSInteger total = [rescut[@"total"] integerValue];
        if (self.latestArray.count >= total) {
            self.contentTableView.mj_footer.hidden = YES;
        }else{
            [self.contentTableView.mj_footer endRefreshing];
        }
        

    } failure:^(NSError *error) {
        
        [self.contentTableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - 加载新的数据
- (void)loadNewComments{
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.word.ID;
    parame[@"hot"] = @"1";
    
    [KKHttpTool get:@"http://api.budejie.com/api/api_open.php" parame:parame success:^(id rescut) {
        
        [self.activiView stopAnimating];
        self.activiView = nil;
        self.contentTableView.tableFooterView = nil;
        
        
        if (![rescut isKindOfClass:[NSDictionary class]]) return ;
//        /Users/wangyakang/Desktop
//        [rescut writeToFile:@"/Users/wangyakang/Desktop/data.plist" atomically:YES];
        
        self.hotArray = [KKComment mj_objectArrayWithKeyValuesArray:rescut[@"hot"]];
        self.latestArray = [KKComment mj_objectArrayWithKeyValuesArray:rescut[@"data"]];
        
        self.page = 1;
        
        [self.contentTableView reloadData];
        
        [self.contentTableView.mj_header endRefreshing];
        
        NSInteger total = [rescut[@"total"] integerValue];
        if (self.latestArray.count >= total) {
            self.contentTableView.mj_footer.hidden = YES;
        }
        
        [self.contentTableView setContentOffset:CGPointMake(0, self.headerHeight) animated:YES];

    } failure:^(NSError *error) {
        
        [self.contentTableView.mj_header endRefreshing];
    }];
    
    
}

#pragma mark - 控制器销毁
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.saveHotCmt.count) {
        
        self.word.top_cmt = self.saveHotCmt;
        [self.word setValue:@0 forKey:@"cellHeight"];
    }
    
    // 取消全部 网络请求
    // 取消请求
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //  销毁会话管理者
//    [self.manager invalidateSessionCancelingTasks:NO];
    
}

// Basic 设置 nav 键盘设置
- (void)setupBasic{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentTableView.contentInset = UIEdgeInsetsMake(64, 0, 10, 0);
    
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = KKGlobalBg;
    
    self.title = @"热门评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"comment_nav_item_share_icon" highImageName:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    // 自动计算行高，设置估算行高
    self.contentTableView.estimatedRowHeight = 64;
    // 告诉系统，行高你来算
    self.contentTableView.rowHeight = UITableViewAutomaticDimension;
    
    // 注册 cell
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKCommentCell class] ) bundle:nil] forCellReuseIdentifier:KKCellID];

//    self.contentTableView.mj_footer.hidden = YES;
    
    // 注册通知，监听键盘弹出，和消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

// 修改底部框的frame
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.barButtom.constant = HEIGHT - rect.origin.y;
    
    CGFloat keyAnimaDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:keyAnimaDuration animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}


#pragma mark - table view delegate

// 当scrollView 将要开始滚动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    KKLog(@"%s -- menu %@",__func__,menu);
    [menu setMenuVisible:NO animated:YES];

    
    [self.view endEditing:YES];
}
/**
 *  根据组 返回 对应的数据源
 *
 *  @param section 组
 *
 *  @return 数据源
 */
- (NSArray *)commentInSection:(NSInteger)section{
    
    if (section == 0) { // 第0组，可能是最热评论，也可能是最新评论
        return self.hotArray.count ? self.hotArray : self.latestArray;
    }
    // 一定不是最热评论
    return self.latestArray;
    
}

/**
 *  根据indexpath 返回 对应的模型
 *
 *  @param index 第几组（section） 第几个（row）
 *
 *  @return 模型对向
 */
- (KKComment *)commentInIndexPath:(NSIndexPath *)index{
    
    // 第几组，第几个对象
    return [self commentInSection:index.section][index.row];
    
}


#pragma mark - table data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotCount = self.hotArray.count;
    NSInteger latestCount = self.latestArray.count;
    
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSInteger hotCount = self.hotArray.count;
    NSInteger latestCount = self.latestArray.count;

    tableView.mj_footer.hidden = (latestCount == 0);

    if (section == 0) {// 第0组
        return hotCount ? hotCount : latestCount;
    }
    // 非第0组
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:KKCellID];
    
    KKComment *cmt = [self commentInIndexPath:indexPath];
    
    cell.cmt = cmt;
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotArray.count;
    
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论" ;
    }else{
        return @"最新评论";
    }
}


#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIMenuController *menu = [UIMenuController sharedMenuController];
    KKLog(@"%s -- menu %@",__func__,menu);
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        
        // 获取被点击的cell
        KKCommentCell *cell = (KKCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        // 获取第一响应者
        [cell becomeFirstResponder];
        
        CGRect rect = CGRectMake(0, cell.height*.5, cell.width, cell.height*.5);
        
        [menu setTargetRect:rect inView:cell];
        
        
        UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        
        UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        
        UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        
        menu.menuItems = @[item1,item2,item3];
        
        [menu setMenuVisible:YES animated:YES];
        
    }
    
}

#pragma mark - menu 操作
- (void)ding:(UIMenuController *)menu{
    
    NSIndexPath *index = [self.contentTableView indexPathForSelectedRow];
    
    KKLog(@"%@ --- %@",menu,[self commentInIndexPath:index].content);
}

- (void)replay:(UIMenuController *)menu{
    
    KKLog(@"%@",menu);
}

- (void)report:(UIMenuController *)menu{
    
    KKLog(@"%@",menu);
}


@end
