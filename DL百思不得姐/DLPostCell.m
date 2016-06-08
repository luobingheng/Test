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
#import "DLPostImageView.h"
#import <Masonry.h>

static CGFloat const DLCellMargin = 10.0;

@interface DLPostCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomBar;


@property (weak, nonatomic) IBOutlet UIButton *loveButton;

@property (weak, nonatomic) IBOutlet UIButton *hateButton;

@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;

//@property (weak, nonatomic) IBOutlet UIImageView *mediaView;

@property (strong, nonatomic)  UIImageView *mediaView;

//@property (weak, nonatomic) IBOutlet UIView *wrapperView;


@property (nonatomic, assign) CGFloat imgW;
@property (nonatomic, assign) CGFloat imgH;

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
    
    self.mainTextLabel.text = post.text;
    
    [self setButton:self.loveButton withNumber:post.love];
    [self setButton:self.hateButton withNumber:post.hate];
    [self setButton:self.repostButton withNumber:post.repost];
    [self setButton:self.commentButton withNumber:post.comment];

    //必须要先在IB里添加控件,自动行高才能有效
    //动态添加图片的自动行高失效
    if (post.type == DLPostTypePicture) {
        self.mediaView = [UIImageView new];
//        [self.wrapperView addSubview:self.mediaView];
        [self.contentView addSubview:self.mediaView];
        
        self.imgW = screenW - 4 * DLCellMargin;
        self.imgH = self.imgW * post.imgHeight / post.imgWidth;
        
        [self.mediaView sd_setImageWithURL:[NSURL URLWithString:post.image] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"] completed:nil];
        self.mediaView.contentMode = UIViewContentModeScaleToFill;
        
//        [self.mediaView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.wrapperView);
//        }];
        
        [self.mediaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.imgW);
            make.height.mas_equalTo(self.imgH);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mainTextLabel.mas_bottom).offset(DLCellMargin);
            make.bottom.mas_equalTo(self.bottomBar.mas_top).offset(-10);
        }];
    }
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
    
    frame.origin.x = DLCellMargin;
    frame.origin.y += DLCellMargin;
    frame.size.width -= 2 * DLCellMargin;
    
    [super setFrame:frame];
}

@end
