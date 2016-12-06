//
//  JGSquareCell.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/22.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGSquareCell.h"
#import "JGSquareItem.h"
#import <UIImageView+WebCache.h>

@interface JGSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation JGSquareCell
-(void)setSquareItem:(JGSquareItem *)squareItem{
    _squareItem = squareItem ;
    //设置文字
    self.nameLabel.text = squareItem.name ;
    //设置图片
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:squareItem.icon]] ;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
