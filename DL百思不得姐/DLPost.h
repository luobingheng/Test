//
//  DLPost.h
//  DL百思不得姐
//
//  Created by Dan on 16/5/30.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLPost : NSObject

@property (nonatomic, copy) NSString *name;//昵称

@property (nonatomic, copy) NSString *text;//征文

@property (nonatomic, copy) NSString *profile_image;//头像

@property (nonatomic, copy) NSString *created_at;//发布时间

@property (nonatomic, copy) NSString *love;//赞数量

@property (nonatomic, copy) NSString *hate;//踩数量

@property (nonatomic, copy) NSString *repost;//转发数

@property (nonatomic, copy) NSString *comment;//评论数


@end
