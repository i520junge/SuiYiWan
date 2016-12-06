//
//  UIBarButtonItem+Item.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/16.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
//设置导航条左右的按钮
+(instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal] ;
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted] ;
    [btn sizeToFit] ;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside] ;
    
    //把按钮包装在view里面，防止按钮点击范围扩大的bug
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds] ;
    [view addSubview:btn] ;
    
    return [[UIBarButtonItem alloc] initWithCustomView:view] ;
}

+(instancetype)itemWithImageName:(NSString *)imageName selectImageName:(NSString *)selectImageName target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal] ;
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected] ;
    [btn sizeToFit] ;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside] ;
    
    //把按钮包装在view里面，防止按钮点击范围扩大的bug
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds] ;
    [view addSubview:btn] ;
    
    return [[UIBarButtonItem alloc] initWithCustomView:view] ;
}
@end
