//
//  JGNavigationBar.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGNavigationBar.h"

@implementation JGNavigationBar

-(void)layoutSubviews{
    [super layoutSubviews] ;
    
    //设置返回按钮距离左边距离为5
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"JGBackView")]) {
            view.JG_x = 5 ;
        }
    }
}

@end
