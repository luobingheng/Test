//
//  DLTextField.m
//  DL百思不得姐
//
//  Created by Dan on 16/5/25.
//  Copyright © 2016年 orgName. All rights reserved.
//
//
#import "DLTextField.h"
#import <objc/runtime.h>

@implementation DLTextField

- (BOOL)becomeFirstResponder{
    [super becomeFirstResponder];
    
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];//用kvc设置成员变量属性
    return YES;
}

- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return YES;
}

- (void)getIvarName{
    
    unsigned int count = 0;
    
    //获得成员变量数组
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i=0; i<count; i++) {
        NSLog(@"%s", ivar_getName(ivars[i]));//获得第i个成员变量名
    }
}

@end
