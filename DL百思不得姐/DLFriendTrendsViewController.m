//
//  DLFollowingViewController.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLFriendTrendsViewController.h"
#import "UIBarButtonItem+DLCateogy.h"
#import "DLRecommendViewController.h"
#import "DLLoginController.h"

//关注
@interface DLFriendTrendsViewController ()

@end

@implementation DLFriendTrendsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highlightedImageName:@"friendsRecommentIcon-click" target:self selector:@selector(showRecommendUser)];

}

- (void)showRecommendUser{
    DLRecommendViewController *vc = [DLRecommendViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showLoginController:(id)sender {

    DLLoginController *loginVC = [DLLoginController new];
    
    [self presentViewController:loginVC animated:YES completion:nil];
}


@end
