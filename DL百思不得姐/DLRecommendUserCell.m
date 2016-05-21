//
//  DLRecommendUserCell.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/19.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLRecommendUserCell.h"
#import "DLRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface DLRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation DLRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];

    self.contentView.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1);
//    self.textLabel.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.contentView.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.textLabel.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];

}



- (void)setUser:(DLRecommendUser *)user{
    _user = user;
    
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:user.header]];
    
    self.screenNameLabel.text = user.screen_name;
    
    self.fansCountLabel.text = user.fans_count;
}

@end
