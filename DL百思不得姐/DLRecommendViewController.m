//
//  DLRecommendViewController.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/18.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLRecommendViewController.h"
#import <AFNetworking.h>
#import "DLRecommendCategory.h"
#import <MJExtension.h>
#import "DLRecommendCategoryCell.h"
#import "DLRecommendUser.h"
#import "DLRecommendUserCell.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>

#define selectedCategory self.categories[[self.categoryTableView indexPathForSelectedRow].row]

static NSString *const categoryCellKey = @"DLRecommendCategoryCell";
static NSString *const userCellKey = @"DLRecommendUserCell";

//推荐分类
@interface DLRecommendViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, copy) NSArray<DLRecommendCategory *> *categories;

@property (nonatomic, strong) AFHTTPSessionManager *manager;


@property (nonatomic, strong) NSDictionary *requestingPar;

@end

/*************************************************************/

/**要解决的细节问题:
1.重复请求
2.网速慢时带来的问题,比如发送了多个请求
3.各种不同操作造成的上下拉控件的状态显示,
*/

/*************************************************************/

@implementation DLRecommendViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self loadCategoires];
    
    [self setUpRefresh];
}

- (void)setUpTableView{
    
    self.view.backgroundColor = DLBackgroundColor;
    self.categoryTableView.backgroundColor = [UIColor clearColor];
    self.userTableView.backgroundColor = [UIColor clearColor];
    self.title = @"推荐分类";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;

    
    [self.categoryTableView registerNib:[UINib nibWithNibName:categoryCellKey bundle:nil] forCellReuseIdentifier:categoryCellKey];
    [self.userTableView registerNib:[UINib nibWithNibName:userCellKey bundle:nil] forCellReuseIdentifier:userCellKey];
    
    self.manager = [AFHTTPSessionManager manager];
    
    self.userTableView.rowHeight = 70;
    

}

- (void)loadCategoires{
    [SVProgressHUD show];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"a"] = @"category";
    par[@"c"] = @"subscribe";

    [self.manager GET:APIString parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        self.categories = [DLRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];//次方法不会调用didSelectRowAtIndexPath:
        
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"宝宝加载失败了..."];
    }];
}


- (void)setUpRefresh{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

}

- (void)loadNewUsers{
    
    DLRecommendCategory *rc = selectedCategory;
    
    if (!rc.users.count) {//如果该类的用户还没加载过(解决重复请求问题)
        
        [self.userTableView.mj_header beginRefreshing];
        
        rc.currentPage = 0;//网速慢时,如果加载这个类未完成又去点击其他类,rc.currentPage会照样增加,所以rc.users还没有东西时,rc.currentPage要为0
        
        NSMutableDictionary *par = [NSMutableDictionary dictionary];
        par[@"a"] = @"list";
        par[@"c"] = @"subscribe";
        par[@"category_id"] = rc.idString;
        par[@"page"] = @(++rc.currentPage);
        self.requestingPar = par;
        
        [self.manager GET:APIString parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
                rc.users = [DLRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                rc.total = [responseObject[@"total"] integerValue];
                
                if (self.requestingPar != par) {
                    return ;
                }
            
                [self.userTableView reloadData];
                
                [self checkFooterState];//刷新下拉控件的状态
                
                [self.userTableView.mj_header endRefreshing];//加载成功后结束header加载状态

            });

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"宝宝加载失败了..."];
            
            [self.userTableView.mj_footer endRefreshing];//失败了也要停止刷新
            [self.userTableView.mj_header endRefreshing];
        }];
    }else{
        [self.userTableView reloadData];//已经加载过用户,直接reload,不用发请求
        
        [self checkFooterState];//如果加载过也要判断
        [self.userTableView.mj_header endRefreshing];//加载成功后结束header加载状态
    }
}

- (void)loadMoreUsers{
    DLRecommendCategory *rc = selectedCategory;
    
    if (rc.users.count != rc.total) {
        
        NSMutableDictionary *par = [NSMutableDictionary dictionary];
        par[@"a"] = @"list";
        par[@"c"] = @"subscribe";
        par[@"category_id"] = rc.idString;
        par[@"page"] = @(++rc.currentPage);
        self.requestingPar = par;
        
        [self.manager GET:APIString parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *users = [DLRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            [rc.users addObjectsFromArray:users];
            
            if (self.requestingPar != par) {
                return ;
            }
            
            [self.userTableView reloadData];

            [self checkFooterState];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"宝宝加载失败了..."];
            
            [self.userTableView.mj_footer endRefreshing];
        }];
    }else{
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];//当全部用户加载过了,则显示已全部加载
    }
    
}

//刷新下拉控件的状态
- (void)checkFooterState{
    
    DLRecommendCategory *rc = selectedCategory;
    
    if (rc.users.count == rc.total) {
        
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];//因为用户可能会在没加载完时返回上一个页面,此时应取消所有请求
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    if (tableView == self.categoryTableView) {
        
        [self.userTableView reloadData];//马上刷新使表格显示当前类的用户而不是上次选择的类的用户
        [self loadNewUsers];

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else{
        DLRecommendCategory *rc = selectedCategory;
        return rc.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView){
        DLRecommendCategoryCell *c = [tableView dequeueReusableCellWithIdentifier:categoryCellKey];
        
        c.category = self.categories[indexPath.row];
        
        return c;
    }else{
        DLRecommendUserCell *c = [tableView dequeueReusableCellWithIdentifier:userCellKey];
        
        DLRecommendCategory *rc = selectedCategory;
        
        c.user = rc.users[indexPath.row];
        
        return c;
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        
        //设置Cell的动画效果为3D效果
        //设置x和y的初始值；
        cell.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1);
        //x和y的最终值为1
        [UIView animateWithDuration:0.3 animations:^{
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }];
    }
}

@end

