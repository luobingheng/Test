//
//  DLRecommendUser.h
//  DL百思不得姐
//
//  Created by Dan on 16/5/19.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLRecommendCategory;

@interface DLRecommendUser : NSObject

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, copy) NSString *fans_count;

@property (nonatomic, strong) DLRecommendCategory *category;

@end
