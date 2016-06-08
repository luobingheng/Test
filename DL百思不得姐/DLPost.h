//
//  DLPost.h
//  DL百思不得姐
//
//  Created by Dan on 16/5/30.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLPostTableController.h"

@interface DLPost : NSObject

@property (nonatomic, assign) DLPostType type;//帖子类型

@property (nonatomic, copy) NSString *name;//昵称

@property (nonatomic, copy) NSString *text;//征文

@property (nonatomic, copy) NSString *profile_image;//头像

@property (nonatomic, copy) NSString *created_at;//发布时间

@property (nonatomic, copy) NSString *love;//赞数量

@property (nonatomic, copy) NSString *hate;//踩数量

@property (nonatomic, copy) NSString *repost;//转发数

@property (nonatomic, copy) NSString *comment;//评论数

@property (nonatomic, strong) NSString *image;//发布的图片

@property (nonatomic, assign) NSInteger imgWidth;//图片的宽

@property (nonatomic, assign) NSInteger imgHeight;//图片的高

@end
