//
//  DLPostTableController.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/27.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLPostTableController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "DLPost.h"
#import <UIImageView+WebCache.h>
#import "DLPostCell.h"

@interface DLPostTableController ()

@property (nonatomic, strong) AFHTTPSessionManager *AFmanager;

@property (nonatomic, strong) NSMutableArray *posts;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSString *maxtime;

@property (nonatomic, strong) NSDictionary *currentPar;


@end

static NSString *const DLPostCellID = @"DLPostCell";

@implementation DLPostTableController

- (NSMutableArray *)posts{
    if (!_posts) {
        _posts = [NSMutableArray array];
    }
    return _posts;
}

- (instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = DLBackgroundColor;
    }
    return self;
}

- (void)setPostType:(DLPostType)postType{
    
    _postType = postType;
    
    switch (self.postType) {
            
        case DLPostTypeAll:
            self.title = @"全部";
            break;
        case DLPostTypeVideo:
            self.title = @"视频";
            break;
        case DLPostTypeAudio:
            self.title = @"音频";
            break;
        case DLPostTypePicture:
            self.title = @"图片";
            break;
        case DLPostTypeText:
            self.title = @"段子";
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.AFmanager = [AFHTTPSessionManager manager];
    
    [self setupRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:DLPostCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DLPostCellID];
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData{
    
    
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"a"] = @"list";
    par[@"c"] = @"data";
    par[@"type"] = @(self.postType);
    self.currentPar = par;
    
    [self.AFmanager GET:APIString parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.posts = [DLPost mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        if (self.currentPar != par) {
            return ;
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        self.page = 0;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.currentPar != par) {
            return ;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadMoreData{
    
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"a"] = @"list";
    par[@"c"] = @"data";
    par[@"type"] = @"29";
    NSInteger page = self.page + 1;
    par[@"page"] = @(self.postType);
    par[@"maxtime"] = self.maxtime;
    self.currentPar = par;
    
    [self.AFmanager GET:APIString parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *posts = [DLPost mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.posts addObjectsFromArray:posts];
        
        if (self.currentPar != par) {
            return ;
        }
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        self.page = page;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.currentPar != par) {
            return ;
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLPostCell *c = [tableView dequeueReusableCellWithIdentifier:DLPostCellID];
    
    c.post = self.posts[indexPath.row];
    
    return c;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

@end
