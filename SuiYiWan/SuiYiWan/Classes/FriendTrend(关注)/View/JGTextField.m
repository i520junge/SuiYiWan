//
//  JGTextField.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGTextField.h"
#import "UITextField+placeholderColor.h"

@implementation JGTextField
-(void)awakeFromNib{
    [super awakeFromNib];
    //设置刚一加载时TextField里面占位字符的颜色
    self.placeholderColor = [UIColor lightGrayColor] ;
//    [self setPlaceholderTextColor:[UIColor lightGrayColor]] ;

    //设置光标颜色
    self.tintColor = [UIColor whiteColor] ;
    //开启右边删除小按钮
    self.clearButtonMode = UITextFieldViewModeAlways ;
    //设置监听编辑状态
//    [self addTarget:self action:@selector(textEditBegain) forControlEvents:UIControlEventEditingDidBegin] ;
//    [self addTarget:self action:@selector(textEditEnd) forControlEvents:UIControlEventEditingDidEnd] ;
    
}

#pragma mark - 监听文本编辑状态
-(BOOL)becomeFirstResponder{
    self.placeholderColor = [UIColor whiteColor] ;
    return [super becomeFirstResponder] ;
}
-(BOOL)resignFirstResponder{
    self.placeholderColor = [UIColor lightGrayColor] ;
    return [super resignFirstResponder] ;
}
/*
-(void)textEditBegain{
    self.placeholderColor = [UIColor whiteColor] ;
//    [self setPlaceholderTextColor:[UIColor whiteColor]] ;
}
-(void)textEditEnd{
    self.placeholderColor = [UIColor lightGrayColor] ;
//    [self setPlaceholderTextColor:[UIColor lightGrayColor]] ;
}

#pragma mark - 设置占位文字的颜色
//-(void)setPlaceholderTextColor:(UIColor *)color{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary] ;
//    dict[NSForegroundColorAttributeName] = color ;
//    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict] ;
//    self.attributedPlaceholder = attr ;
//}

*/

@end
