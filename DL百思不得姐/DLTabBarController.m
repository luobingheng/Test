//
//  DLTabBarController.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLTabBarController.h"
#import "DLEssenceViewController.h"
#import "DLNewPostViewController.h"
#import "DLFollowingViewController.h"
#import "DLMeViewController.h"



@interface DLTabBarController ()

@end

@implementation DLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setChildVC];
}

- (void)setChildVC{
    
    DLEssenceViewController *essenceVC = [DLEssenceViewController new];
    essenceVC.view.backgroundColor = DLRandomColor;
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:essenceVC]];
    
    DLNewPostViewController *newPostVC = [DLNewPostViewController new];
    newPostVC.view.backgroundColor = DLRandomColor;
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:newPostVC]];
    
    DLFollowingViewController *followingVC = [DLFollowingViewController new];
    followingVC.view.backgroundColor = DLRandomColor;
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:followingVC]];
    
    DLMeViewController *meVC = [DLMeViewController new];
    meVC.view.backgroundColor = DLRandomColor;
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:meVC]];
    
    
}

@end
