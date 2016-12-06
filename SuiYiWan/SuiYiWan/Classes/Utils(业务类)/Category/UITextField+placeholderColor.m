//
//  UITextField+placeholderColor.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/22.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "UITextField+placeholderColor.h"

@implementation UITextField (placeholderColor)
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    //用于存放占位文字的控件placeholderLabel是懒加载的，当预先没有占位文字时，设置占位文字颜色，再设置占位文字时，占位文字颜色是无法设置的，所以为了设置占位文字颜色时就能拿到占位文字的控件，做以下判断
    if (!self.placeholder.length) {
        self.placeholder = @" " ;//给一个空格占位文字
    }
    //    通过打断点找到存放占位文字的属性placeholderLabel，用KVC获取出来
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"] ;
    placeholderLabel.textColor = placeholderColor ;
}
-(UIColor *)placeholderColor{
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"] ;
    return placeholderLabel.textColor ;
}
@end
