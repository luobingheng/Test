//
//  DLLoginController.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/24.
//  Copyright © 2016年 orgName. All rights reserved.
//

#import "DLLoginController.h"


@interface DLLoginController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeadingSuperviewLeading;

@property (weak, nonatomic) IBOutlet UIButton *loginOrRegisterButton;


@end


@implementation DLLoginController

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginOrRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.loginLeadingSuperviewLeading.constant = -self.view.width;
    } else{
        
        self.loginLeadingSuperviewLeading.constant = 0;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutSubviews];
    }];
}

@end
