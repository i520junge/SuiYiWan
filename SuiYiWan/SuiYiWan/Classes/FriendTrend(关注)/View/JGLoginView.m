//
//  JGLoginView.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/20.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGLoginView.h"

@interface JGLoginView ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end
@implementation JGLoginView
+(instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject] ;
}
+(instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject] ;
}


#pragma mark - 处理按钮图片拉伸问题
-(void)awakeFromNib{
    [super awakeFromNib] ;
    
    //设置按钮图片拉伸
    [self setBtnImageStretchable] ;
    
    //解决控制台输出说约束冲突的问题
    self.autoresizingMask = UIViewAutoresizingNone ;
}


//设置按钮图片拉伸
-(void)setBtnImageStretchable{
    //方法一：获取当前背景图片，缺点：无法设置2个状态
    //    UIImage *image = self.loginBtn.currentBackgroundImage  ;
    //    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5] ;
    //    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal] ;
    
    //方法二：直接获取不同状态下的图片
    //取出正常状态下按钮的背景图片，进行拉伸
    UIImage *image1 = [self.loginBtn backgroundImageForState:UIControlStateNormal] ;
    image1 = [image1 stretchableImageWithLeftCapWidth:image1.size.width*0.5 topCapHeight:image1.size.height*0.5] ;
    [self.loginBtn setBackgroundImage:image1 forState:UIControlStateNormal] ;
    
    //取出高亮状态下按钮的背景图片，进行拉伸
    UIImage *image2 = [self.loginBtn backgroundImageForState:UIControlStateHighlighted] ;
    image2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width*0.5 topCapHeight:image2.size.height*0.5] ;
    [self.loginBtn setBackgroundImage:image2 forState:UIControlStateHighlighted] ;
}


@end
