//
//  UIBarButtonItem+DLCateogy.h
//  DL百思不得姐
//
//  Created by Dan on 16/5/18.
//  Copyright © 2016年 orgName. All rights reserved.
//

//(自定义导航栏按钮)

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DLCateogy)

+ (instancetype)dl_itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector;

+ (instancetype)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector;

@end
