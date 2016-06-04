//
//  NSDate+DLExtension.m
//  DL百思不得姐
//
//  Created by Dan on 16/6/3.
//  Copyright © 2016年 orgName. All rights reserved.
//

//计算时间差
//判断时间区间

#import "NSDate+DLExtension.h"

NSString * const dl_dateFormat = @"yyyy-MM-dd HH:mm:ss";

@implementation NSDate (DLExtension)

- (NSDateComponents *)dl_dateComponentsFromDate:(NSDate *)fromDate{
    
    NSCalendar *ca = [NSCalendar currentCalendar];
    
    NSCalendarUnit u = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [ca components:u fromDate:fromDate toDate:self options:0];
}

- (NSDateComponents *)dl_dateComponentsFromDateString:(NSString *)fromDateString withDateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = dateFormat;
    NSDate *fromDate = [fmt dateFromString:fromDateString];//用NSDateFormatter转化后会自动把时间设定为0时区
    
    return [self dl_dateComponentsFromDate:fromDate];
}

- (BOOL)dl_isThisYear{
    
    NSCalendar *ca = [NSCalendar currentCalendar];
    
    NSInteger currentYear = [ca component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [ca component:NSCalendarUnitYear fromDate:self];
    
    return currentYear == selfYear;
}

- (BOOL)dl_isYesterday{
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *currentDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *ca = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [ca components:NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay fromDate:selfDate toDate:currentDate options:0];
    
    if (comps.year == 0 && comps.month == 0 && comps.day == 1) {
        return YES;
    } else{
        return NO;
    }
}

- (BOOL)dl_isToday{
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *currentDateStr = [fmt stringFromDate:[NSDate date]];
    NSString *selfDateStr = [fmt stringFromDate:self];
    
    return [currentDateStr isEqualToString:selfDateStr];
}

+ (NSString *)dl_timeDescriptionFromDate:(NSDate *)fromDate{
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    
    if (fromDate.dl_isThisYear) { // 今年
        if (fromDate.dl_isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] dl_dateComponentsFromDate:fromDate];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (fromDate.dl_isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:fromDate];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:fromDate];
        }
    } else { // 非今年
        return [fmt stringFromDate:fromDate];
    }
}


+ (NSString *)dl_timeDescriptionFromDateString:(NSString *)fromDateString withDateFormat:(NSString *)dateFormat{
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = dateFormat;
    NSDate *date = [fmt dateFromString:fromDateString];
    
    return [self dl_timeDescriptionFromDate:date];
}

@end
