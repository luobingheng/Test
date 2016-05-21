//
//  DLCategory.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/18.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLRecommendCategory.h"
#import <MJExtension.h>


@implementation DLRecommendCategory

- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"idString":@"id"};
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%ld %@ %@", self.count, self.idString, self.name];
}



@end
