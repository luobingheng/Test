//
//  DLRecommendTagsViewController.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/21.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLRecommendTagsViewController.h"
#import "DLRecommendTag.h"
#import "DLRecommendTagCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

//推荐关注
@interface DLRecommendTagsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tagsTableView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *tags;

@end

static NSString *const tagsCellKey = @"DLRecommendTagCell";

@implementation DLRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self loadTags];
}

- (void)setUpTableView{
    
    [self.tagsTableView registerNib:[UINib nibWithNibName:tagsCellKey bundle:nil] forCellReuseIdentifier:tagsCellKey];
    
    self.view.backgroundColor = DLBackgroundColor;
    
    self.tagsTableView.backgroundColor = [UIColor clearColor];
    self.title = @"推荐关注";
    
    self.manager = [AFHTTPSessionManager manager];
    self.tagsTableView.rowHeight = 70;
    
    self.tags = [NSMutableArray array];
}

- (void)loadTags{
    [SVProgressHUD  show];
    
    if (!self.tags.count) {
        
        NSMutableDictionary *par = [NSMutableDictionary dictionary];
        par[@"a"] = @"tag_recommend";
        par[@"c"] = @"topic";
        par[@"action"] = @"sub";
        
        [self.manager GET:APIString parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.tags = [DLRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
            
            [self.tagsTableView reloadData];

            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showErrorWithStatus:@"宝宝加载失败了..."];
            NSLog(@"%@",error);
        }];
        
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DLRecommendTagCell *c = [tableView dequeueReusableCellWithIdentifier:tagsCellKey];
    
    c.recommendTag = self.tags[indexPath.row];
    
    return c;
}

@end
