//
//  JGBottomView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/26.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGBottomView.h"

@interface JGBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@end
@implementation JGBottomView
-(void)setItem:(JGTopicItem *)item{
    [super setItem:item] ;
    
    //设置按钮的初始化文字
    [self setUpButton:_dingBtn count:item.ding title:@"赞"] ;
    [self setUpButton:_caiBtn count:item.cai title:@"踩"] ;
    [self setUpButton:_shareBtn count:item.cai title:@"转发"] ;
    [self setUpButton:_commentBtn count:item.cai title:@"评论"] ;   
}

/**
 设置按钮的初始化文字

 @param btn   要设置的按钮
 @param count 赞、踩、转发、评论的数量
 @param title 初始文字
 */
-(void)setUpButton:(UIButton *)btn count:(CGFloat)count title:(NSString *)title{
    NSString *str = title ;
    //大于1万的时候
    if (count >= 10000) {
        count = count/10000 ;
        str = [NSString stringWithFormat:@"%.1f万",count] ;
        
    }else if (count > 0){
        
        //一定要写上.0f，不然数据后面会有很多.000000，
        str = [NSString stringWithFormat:@"%.0f",count] ;
    }
    //将.0替换掉
    [str stringByReplacingOccurrencesOfString:@".0" withString:@""] ;
    [btn setTitle:str forState:UIControlStateNormal] ;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted] ;
    
}

@end
