//
//  NSDate+DLExtension.h
//  DL百思不得姐
//
//  Created by Dan on 16/6/3.
//  Copyright © 2016年 orgName. All rights reserved.
//

//计算时间差
//判断时间区间

#import <Foundation/Foundation.h>

#define DLDate [NSDate dateWithTimeInterval:60*60*8 sinceDate:[NSDate date]]

UIKIT_EXTERN NSString * const dl_dateFormat;

@interface NSDate (DLExtension)

- (NSDateComponents *)dl_dateComponentsFromDate:(NSDate *)fromDate;

- (NSDateComponents *)dl_dateComponentsFromDateString:(NSString *)fromDateString withDateFormat:(NSString *)dateFormat;

- (BOOL)dl_isThisYear;

- (BOOL)dl_isYesterday;

- (BOOL)dl_isToday;

+ (NSString *)dl_timeDescriptionFromDateString:(NSString *)fromDateString withDateFormat:(NSString *)dateFormat;

+ (NSString *)dl_timeDescriptionFromDate:(NSDate *)fromDate;

@end
