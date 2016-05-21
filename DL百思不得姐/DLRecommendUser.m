//
//  DLRecommendUser.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/19.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLRecommendUser.h"

@implementation DLRecommendUser

- (NSString *)description{
    return [NSString stringWithFormat:@"%@  %@  %@", self.header, self.screen_name, self.fans_count];
}

@end
