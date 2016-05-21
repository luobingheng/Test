//
//  UIBarButtonItem+DLCateogy.h
//  DL百思不得姐
//
//  Created by Dan on 16/5/18.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DLCateogy)

+ (instancetype)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector;

@end
