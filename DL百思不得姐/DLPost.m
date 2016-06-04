//
//  DLPost.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/30.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLPost.h"

@implementation DLPost

- (NSString *)created_at{

    return [NSDate dl_timeDescriptionFromDateString:_created_at withDateFormat:dl_dateFormat];
}

@end
