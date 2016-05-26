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

//精华
@interface DLEssenceViewController ()

@end

@implementation DLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highlightedImageName:@"MainTagSubIconClick" target:self selector:@selector(showRecommendTags)];

    [self setUpTitles];
}

- (void)setUpTitles{
    
}

- (void)showRecommendTags{
    DLRecommendTagsViewController *vc = [DLRecommendTagsViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
