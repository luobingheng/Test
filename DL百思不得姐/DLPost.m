//
//  DLPost.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/30.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLPost.h"
#import <MJExtension.h>

@implementation DLPost

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"image":@"image1",
             @"imgWidth":@"width",
             @"imgHeight":@"height"
             };//左边是自己的名字,右边是服务器的
}

- (NSString *)created_at{

    return [NSDate dl_timeDescriptionFromDateString:_created_at withDateFormat:dl_dateFormat];
}

@end
