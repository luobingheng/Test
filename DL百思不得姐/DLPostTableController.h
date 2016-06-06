//
//  DLPostTableController.h
//  DL百思不得姐
//
//  Created by Dan on 16/6/4.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import <UIKit/UIKit.h>

//1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
typedef NS_ENUM(NSInteger, DLPostType) {
    DLPostTypeAll = 1,
    DLPostTypeVideo = 41,
    DLPostTypeAudio = 31,
    DLPostTypePicture = 10,
    DLPostTypeText = 29
};

@interface DLPostTableController : UITableViewController

@property (nonatomic, assign) DLPostType postType;

@end
