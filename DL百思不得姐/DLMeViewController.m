//
//  DLMeViewController.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLMeViewController.h"
#import "UIBarButtonItem+DLCateogy.h"

@interface DLMeViewController ()

@end

@implementation DLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" highlightedImageName:@"mine-setting-icon-click" target:self selector:@selector(tagPress)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" highlightedImageName:@"mine-moon-icon-click" target:self selector:@selector(moonPress)];
    
    //注意设置多个item时的顺序
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)tagPress{
    NSLog(@"%s", __func__);
}

- (void)moonPress{
    NSLog(@"%s", __func__);
    
}

@end
