//
//  DLGuidanceView.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/26.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLGuidanceView.h"

@interface DLGuidanceView ()

@end

@implementation DLGuidanceView

+ (void)show{
    NSString *versionKey = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:versionKey];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        
        DLGuidanceView *gv = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DLGuidanceView class]) owner:nil options:nil].firstObject;
        
        [[UIApplication sharedApplication].keyWindow addSubview:gv];
    }
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
}

- (IBAction)buttonPress:(id)sender {
    [self removeFromSuperview];
}

@end
