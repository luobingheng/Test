//
//  DLRecommendCategoryCell.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/19.
//  Copyright © 2016年 orgName. All rights reserved.
//


#import "DLRecommendCategoryCell.h"

@interface DLRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation DLRecommendCategoryCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = DLColor(250, 250, 250);
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    //选中时的颜色
    self.selectedIndicator.hidden = !selected;
    self.selectedIndicator.backgroundColor = [UIColor redColor];
    self.textLabel.textColor = selected ? [UIColor redColor] : DLColor(78, 78, 78) ;
    
    //动画
    self.selectedIndicator.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
    self.textLabel.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.selectedIndicator.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.textLabel.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (void)setCategory:(DLRecommendCategory *)category{
    _category = category;
    
    self.textLabel.text = category.name;
}

@end
