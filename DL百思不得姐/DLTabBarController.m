//
//  DLTabBarController.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLTabBarController.h"
#import "DLEssenceViewController.h"
#import "DLNewViewController.h"
#import "DLFriendTrendsViewController.h"
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
    [self setChildVCs];
    [self setTabBarStyle];
    
    //设置只读属性可以用kvc
    [self setValue:[DLTabBar new] forKey:@"tabBar"];
}

- (void)setTabBarStyle{
    //设置所有UITabBarItem类的属性
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrNormal[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];//正常状态的属性
    
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];//选中状态
}

- (void)setChildVCs{
    
    [self setChildVC:[DLEssenceViewController new] withTitle:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
    [self setChildVC:[DLNewViewController new] withTitle:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    
    [self setChildVC:[DLFriendTrendsViewController new] withTitle:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    [self setChildVC:[DLMeViewController new] withTitle:@"我" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
    
}

- (void)setChildVC:(UIViewController *)vc withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    vc.view.backgroundColor = DLRandomColor;
    vc.title = title;//设置vc的标题会自动设置tabBarItem的标题
    
    //要设置tabBarItem的图片,要在vc的tabBarItem属性设置
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //设置导航栏的背景图片
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
    
    
}


@end
