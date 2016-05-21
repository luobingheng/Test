//
//  DLNavigationController.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/18.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLNavigationController.h"
#import "DLRecommendViewController.h"
#import <BlocksKit+UIKit.h>

@implementation DLNavigationController

//当这个类第一次接收信息前会调用一次
+ (void)initialize{
    //appearance方法会把这个类里所有带UI_APPEARANCE_SELECTOR的方法,运用到此类的所有实例中
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {//由于pushViewController: 方法写在后面,所以这里判断时,NavigationController还未把viewController加入到子控制器
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//让内容偏左
        
        [button bk_addEventHandler:^(id sender) {//点击事件
            [self popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        //往导航栏左边移动
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        //文字不显示是因为没设置颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

        CGRect r = button.frame;
        r.size = CGSizeMake(70, 30);
        button.frame = r;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;//push的时候隐藏tabBar
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
