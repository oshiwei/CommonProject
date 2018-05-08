//
//  RootListViewController.m
//  HEBox
//
//  Created by wangzw on 2017/12/1.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "RootListViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface RootListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RootListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _showHeader = YES;
        //默认隐藏当前的加载更多控件
        _showFooter = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - private

- (MJRefreshNormalHeader *)refreshHeader {
    //头部刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    return header;
}

- (MJRefreshAutoNormalFooter *)refreshFooter {
    //底部刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    // 设置文字
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多内容了" forState:MJRefreshStateNoMoreData];
    
    return footer;
}

#pragma mark - public method

- (void)createTableViewWithStyle:(UITableViewStyle)style {
    if (self.tableView == nil && self.collectionView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = CViewBgColor;
        
        // 设置header
        self.tableView.mj_header = [self refreshHeader];
        self.tableView.mj_header.hidden = !self.showHeader;
        
        // 设置footer
        self.tableView.mj_footer = [self refreshFooter];
        self.tableView.mj_footer.hidden = !self.showFooter;
        
        self.tableView.tableFooterView = [[UIView alloc] init];
        
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (void)createCollectionViewWithLayout:(UICollectionViewLayout *)layout {
    if (self.tableView == nil && self.collectionView == nil) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = CViewBgColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        //修复iOS10 系统快速滑动闪退问题
        if (@available(iOS 10.0, *)) {
            self.collectionView.prefetchingEnabled = NO;
        }
        
        // 设置header
        self.collectionView.mj_header = [self refreshHeader];
        self.collectionView.mj_header.hidden = !self.showHeader;
        
        // 设置footer
        self.collectionView.mj_footer = [self refreshFooter];
        self.collectionView.mj_footer.hidden = !self.showFooter;
        
        [self.view addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
    }
}

- (void)createTableView {
    [self createTableViewWithStyle:UITableViewStylePlain];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [self createCollectionViewWithLayout:layout];
}

- (void)beginHeaderRefreshing {
    if (self.tableView) {
        [self.tableView.mj_header beginRefreshing];
    }
    if (self.collectionView) {
        [self.collectionView.mj_header beginRefreshing];
    }
}

- (void)beginFooterRefreshing {
    if (self.tableView) {
        [self.tableView.mj_footer beginRefreshing];
    }
    if (self.collectionView) {
        [self.collectionView.mj_footer beginRefreshing];
    }
}

- (void)headerRefreshing {
    //头部下拉刷新，子类中重载
}

- (void)footerRefreshing {
    //底部加载更多，子类中重载
}

- (void)endRefreshing {
    if (self.tableView) {
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
    }
    if (self.collectionView) {
        if (self.collectionView.mj_header.isRefreshing) {
            [self.collectionView.mj_header endRefreshing];
        }
        if (self.collectionView.mj_footer.isRefreshing) {
            [self.collectionView.mj_footer endRefreshing];
        }
    }
}

- (void)showFooterNoneData:(NSString *)noneDataString {
    self.showFooter = YES;
    if (self.tableView) {
        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:noneDataString forState:MJRefreshStateNoMoreData];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.collectionView) {
        [(MJRefreshAutoNormalFooter *)self.collectionView.mj_footer setTitle:noneDataString forState:MJRefreshStateNoMoreData];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //子类中重载
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //子类中重载
    return nil;
}

#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //子类中重载
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //子类中重载
    return nil;
}

#pragma mark - setter

- (void)setShowHeader:(BOOL)showHeader {
    _showHeader = showHeader;
    if (self.tableView) {
        self.tableView.mj_header.hidden = !showHeader;
    }
    if (self.collectionView) {
        self.collectionView.mj_header.hidden = !showHeader;
    }
}

- (void)setShowFooter:(BOOL)showFooter {
    _showFooter = showFooter;
    if (self.tableView) {
        self.tableView.mj_footer.hidden = !showFooter;
    }
    if (self.collectionView) {
        self.collectionView.mj_footer.hidden = !showFooter;
    }
}

@end
