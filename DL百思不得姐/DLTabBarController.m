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
#import "DLTabBar.h"


@interface DLTabBarController ()

@end

@implementation DLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUp];
}

- (void)setUp{
    
    [self setChildVC:[DLEssenceViewController new] withTitle:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
    [self setChildVC:[DLNewPostViewController new] withTitle:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    
    [self setChildVC:[DLFollowingViewController new] withTitle:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    [self setChildVC:[DLMeViewController new] withTitle:@"我" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
    
    
    
    [self setValue:[DLTabBar new] forKey:@"tabBar"];
    

}

- (void)setChildVC:(UIViewController *)vc withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    vc.view.backgroundColor = DLRandomColor;
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:vc]];
}


@end
