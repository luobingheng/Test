//
//  DLTabBar.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLTabBar.h"

@interface DLTabBar ()

@property (nonatomic, strong) UIButton *publishButton;
@end

@implementation DLTabBar

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.publishButton.center = CGPointMake(width/2, height/2);
    
    CGRect rect = self.publishButton.frame;
    rect.size = self.publishButton.currentBackgroundImage.size;
    self.publishButton.frame = rect;
    
    CGFloat itemX;
    CGFloat itemW = self.frame.size.width/5;
    CGFloat itemH = self.frame.size.height;
    NSInteger i = 0;
    
    for (UIView *item in self.subviews) {
//        UITabBarButton是私有属性,不能用[UITabBarButton class]来获取,可用NSClassFromString获取
        if ([item isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            itemX = itemW * ( i>1 ? i+1 : i );
            i++;
            item.frame = CGRectMake(itemX, 0, itemW, itemH);
        }
    }
}



@end
