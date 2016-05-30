//
//  DLEssenceViewController.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLEssenceViewController.h"
#import "UIBarButtonItem+DLCateogy.h"
#import "DLRecommendTagsViewController.h"
#import "DLAllTableController.h"
#import "DLVideoTableController.h"
#import "DLAudioTableController.h"
#import "DLPictureTableController.h"
#import "DLTextTableController.h"

//精华
@interface DLEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedTitleButton;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, strong) UIView *titlesView;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *contentTableViews;

@property (nonatomic, strong) NSArray *titleButtons;

@property (nonatomic, assign) NSInteger scrollIndex;


@end

@implementation DLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highlightedImageName:@"MainTagSubIconClick" target:self selector:@selector(showRecommendTags)];

    [self setupTitlesView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupContentScrollView];
    
    [self scrollViewDidEndDecelerating:self.contentScrollView];
}

#pragma mark - setup

- (void)setupTitlesView{
    
    CGFloat titlesViewH = 35;
    
    //标题栏
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, screenW, titlesViewH)];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    self.titlesView = titlesView;

    //选择指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    [titlesView addSubview:indicator];
    
    NSArray *titles = @[@"全部",@"视频", @"声音", @"图片", @"段子"];
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (int i = 0; i<5; i++) {//添加标题按钮
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(i * screenW / 5, 0, screenW / 5, titlesViewH);
        [b setTitle:titles[i] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        b.titleLabel.font = [UIFont systemFontOfSize:14];
        b.tag = i;//设置tag
        
        [arrM addObject:b];
        [titlesView addSubview:b];
        [b addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            b.enabled = NO;
            self.selectedTitleButton = b;
        }
    }
    self.titleButtons = arrM;
    
    [self.selectedTitleButton layoutSubviews];//强制布局控件,使控件的frame有值
    
    indicator.size = CGSizeMake(self.selectedTitleButton.titleLabel.width, 3);
    indicator.centerX = self.selectedTitleButton.centerX;
    indicator.centerY = self.selectedTitleButton.height - indicator.height;
    
    self.indicator = indicator;
    
    [self.view addSubview:titlesView];
    
}

- (void)selectTitle:(UIButton *)button{
    self.selectedTitleButton.enabled = YES;
    button.enabled = NO;
    self.selectedTitleButton = button;
    
    self.scrollIndex = button.tag;
    
    NSInteger contentOffsetX = self.scrollIndex * screenW;
    [self.contentScrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicator.width = self.selectedTitleButton.titleLabel.width;
        self.indicator.centerX = self.selectedTitleButton.centerX;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setupContentScrollView{
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

    [self.view insertSubview:contentScrollView atIndex:0];
    
    contentScrollView.contentSize = CGSizeMake(self.view.width * 5, 0);
    contentScrollView.delegate = self;
    contentScrollView.pagingEnabled = YES;
    
    self.contentScrollView = contentScrollView;
    
    [self setupContentTable];
}

- (void)setupContentTable{
    
    DLAllTableController *allVC = [DLAllTableController new];
    [self addChildViewController:allVC];
    
    DLVideoTableController *videoVC = [DLVideoTableController new];
    [self addChildViewController:videoVC];
    
    DLAudioTableController *audioVC = [DLAudioTableController new];
    [self addChildViewController:audioVC];
    
    DLPictureTableController *pictureVC = [DLPictureTableController new];
    [self addChildViewController:pictureVC];
    
    DLTextTableController *textVC = [DLTextTableController new];
    [self addChildViewController:textVC];
    
    self.contentTableViews = @[allVC, videoVC, audioVC, pictureVC, textVC];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{//用手拖动才会调用
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
    NSInteger i = scrollView.contentOffset.x / scrollView.width;
    [self selectTitle:self.titleButtons[i]];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    self.scrollIndex = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *contentTable = self.contentTableViews[self.scrollIndex];

    contentTable.tableView.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.width, scrollView.height);
    contentTable.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.titlesView.frame), 0, self.tabBarController.tabBar.height, 0);
;
    contentTable.tableView.scrollIndicatorInsets = contentTable.tableView.contentInset;
    
    [scrollView addSubview:contentTable.tableView];
    
}

- (void)showRecommendTags{
    DLRecommendTagsViewController *vc = [DLRecommendTagsViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
