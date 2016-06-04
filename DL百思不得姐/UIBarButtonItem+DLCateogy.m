//
//  UIBarButtonItem+DLCateogy.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/18.
//  Copyright © 2016年 orgName. All rights reserved.
//

//(自定义导航栏按钮)

#import "UIBarButtonItem+DLCateogy.h"

@implementation UIBarButtonItem (DLCateogy)

+ (instancetype)dl_itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector{
    
    return [self itemWithImageName:imageName highlightedImageName:highlightedImageName target:target selector:selector];
}

+ (instancetype)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];

    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    CGRect rect = button.frame;
    rect.size = button.currentBackgroundImage.size;
    button.frame = rect;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
