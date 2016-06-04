//
//  DLPostCell.m
//  DL百思不得姐
//
//  Created by Dan on 16/6/1.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLPostCell.h"
#import "DLPost.h"
#import <UIImageView+WebCache.h>

@interface DLPostCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *loveButton;

@property (weak, nonatomic) IBOutlet UIButton *hateButton;

@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation DLPostCell

- (void)awakeFromNib {
    UIImageView *backgroundImgView = [UIImageView new];
    backgroundImgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backgroundImgView;
}

- (void)setPost:(DLPost *)post{
    _post = post;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:post.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = post.name;
    
    self.creatTimeLabel.text = post.created_at;
    
    [self setButton:self.loveButton withNumber:post.love];
    [self setButton:self.hateButton withNumber:post.hate];
    [self setButton:self.repostButton withNumber:post.repost];
    [self setButton:self.commentButton withNumber:post.comment];

}

- (void)setButton:(UIButton *)button withNumber:(NSString *)num{
    CGFloat count = num.floatValue;
    
    NSString *countStr;
    if (count > 10000) {
        countStr = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else{
        countStr = [NSString stringWithFormat:@"%@", num];
    }
    [button setTitle:countStr forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame{
    CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}

@end
