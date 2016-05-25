//
//  DLLoginButton.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/24.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLLoginButton.h"

@implementation DLLoginButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(0, self.width, self.width, self.height - self.width);
}

@end
