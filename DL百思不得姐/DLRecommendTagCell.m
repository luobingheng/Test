//
//  DLRecommendTagCell.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/21.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLRecommendTagCell.h"
#import <UIImageView+WebCache.h>
#import "DLRecommendTag.h"

@interface DLRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumerLabel;

@end

@implementation DLRecommendTagCell

- (void)awakeFromNib {
    self.contentView.backgroundColor = DLColor(240, 240, 240);
}

- (void)setRecommendTag:(DLRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list]];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSInteger subNumer = [recommendTag.sub_number integerValue];
    if (subNumer < 10000) {
        self.subNumerLabel.text = [NSString stringWithFormat:@"%ld人订阅", subNumer];
    }else{
        NSString *s = [NSString stringWithFormat:@"%.1f万人订阅", subNumer/10000.0];
        self.subNumerLabel.text = s;
    }
}

//重写setFrame:方法可以使别人修改不到控件frame
- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= frame.origin.x;
    
    [super setFrame:frame];
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    self.contentView.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1);
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.contentView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}
@end
