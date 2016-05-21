//
//  DLNewPostViewController.m
//  DL百思不得姐
//
//  Created by 罗炳恒 on 16/5/15.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLNewViewController.h"
#import "UIBarButtonItem+DLCateogy.h"

@interface DLNewViewController ()

@end

@implementation DLNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highlightedImageName:@"MainTagSubIconClick" target:self selector:@selector(tagPress)];
    
}

- (void)tagPress{
    NSLog(@"%s", __func__);
}

@end
