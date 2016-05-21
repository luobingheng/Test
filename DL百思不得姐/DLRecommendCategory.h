//
//  DLCategory.h
//  DL百思不得姐
//
//  Created by Dan on 16/5/18.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DLRecommendCategory : NSObject


@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *idString;

@property (nonatomic, copy) NSString *name;


@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger currentPage;

@end
