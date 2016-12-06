//
//  JGFastLoginBtn.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/20.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGFastLoginBtn.h"


@implementation JGFastLoginBtn

//图片在上面，文字在下面
-(void)layoutSubviews{
    [super layoutSubviews] ;
    //设置图片
    self.imageView.JG_centerX = self.JG_width * 0.5 ;
    self.imageView.JG_y = 0 ;
    
    //设置文字
    // 以后如果要设置中心点，一定要先设置尺寸
    // 先计算文字宽度，在设置label宽度
    //    CGFloat w = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:18]].width;
    //    self.titleLabel.xmg_width = w;
    [self.titleLabel sizeToFit];
    self.titleLabel.JG_centerX = self.JG_width * 0.5;
//    self.titleLabel.JG_y = self.JG_height - self.titleLabel.JG_height ;
    self.titleLabel.JG_y = CGRectGetMaxY(self.imageView.frame) + 5;
}
+(instancetype)buttonWithNormalImageName:(NSString *)imageName title:(NSString *)title{
    JGFastLoginBtn *btn = [self buttonWithType:UIButtonTypeCustom] ;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal] ;
//    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted] ;
    [btn setTitle:title forState:UIControlStateNormal] ;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    btn.titleLabel.font = [UIFont systemFontOfSize:15] ;
    return btn ;
}

@end
