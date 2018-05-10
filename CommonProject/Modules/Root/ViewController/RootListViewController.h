//
//  RootListViewController.h
//  CommonProject
//
//  Created by wangzw on 2017/12/1.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "RootViewController.h"

@interface RootListViewController : RootViewController
<
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>

/**
 UITableView和UICollectionView只能二选一
 */
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 创建tableView

 @param style tableView类型
 */
- (void)createTableViewWithStyle:(UITableViewStyle)style;

/**
 创建collectionView

 @param layout collectionView的layout
 */
- (void)createCollectionViewWithLayout:(UICollectionViewLayout *)layout;

/**
 创建tableView style=UITableViewStylePlain
 */
- (void)createTableView;

/**
 创建collectionView layout为UICollectionViewFlowLayout
 */
- (void)createCollectionView;

//是否显示头部下拉刷新，默认yes
@property (nonatomic, assign) BOOL showHeader;
//是否显示底部加载更多，默认no
@property (nonatomic, assign) BOOL showFooter;

//开启头部刷新
- (void)beginHeaderRefreshing;

//开启底部加载
- (void)beginFooterRefreshing;

//结束刷新（header、footer）
- (void)endRefreshing;

//结束footer刷新，显示无更多数据提示
- (void)showFooterNoneData:(NSString *)noneDataString;

#pragma mark - ------子类中重载------

//头部下拉刷新，子类中重载
- (void)headerRefreshing;

//底部加载更多，子类中重载
- (void)footerRefreshing;

@end
