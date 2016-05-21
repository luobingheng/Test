//
//  DLEssenceViewController.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLEssenceViewController.h"
#import "UIBarButtonItem+DLCateogy.h"

@interface DLEssenceViewController ()

@end

@implementation DLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highlightedImageName:@"MainTagSubIconClick" target:self selector:@selector(showTags)];
    
}

- (void)showTags{
    NSLog(@"%s", __func__);
}


@end
