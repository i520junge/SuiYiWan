//
//  JGUserCell.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/31.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGUserCell.h"
#import "JGUserItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Randar.h"


@interface JGUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end
@implementation JGUserCell
-(void)setUserItem:(JGUserItem *)userItem{
    _userItem = userItem ;
    
    _themeLabel.text = userItem.screen_name ;
    
    //设置订阅人数
    CGFloat numble = [userItem.fans_count floatValue] ;

    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",userItem.fans_count] ;
    if (numble > 10000) {
        numble = numble/10000.0 ;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numble] ;
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""] ;
        
    }
    _numberLabel.text = numStr ;
    
    //设置图片
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:userItem.header] ] ;
    //用运行时在XIB设置圆角和剪切成圆形图片
}

//设置分割线
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 2 ;
    [super setFrame:frame] ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
