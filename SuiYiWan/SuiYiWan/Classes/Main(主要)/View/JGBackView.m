//
//  JGBackView.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGBackView.h"

@implementation JGBackView
+(instancetype)backViewWithBtnNormalImageName:(NSString *)normalImageName highImageName:(NSString *)highImageName normalTitle:(NSString *)normalTitle highTitle:(NSString *)highTitle target:(id)target action:(SEL)action{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    //设置按钮图片
    [backBtn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal] ;
    [backBtn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted] ;
    //设置按钮文字
    [backBtn setTitle:normalTitle forState:UIControlStateNormal] ;
    [backBtn setTitle:highTitle forState:UIControlStateHighlighted] ;
    //设置按钮文字颜色
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted] ;
    [backBtn sizeToFit] ;
    
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside] ;
    JGBackView *backView = [[JGBackView alloc] init] ;

    backView.frame = backBtn.bounds ;
    [backView addSubview:backBtn] ;
    return backView ;
}
@end
