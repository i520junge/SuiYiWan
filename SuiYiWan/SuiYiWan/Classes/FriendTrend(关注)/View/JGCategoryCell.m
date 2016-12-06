//
//  JGCategoryCell.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/31.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGCategoryCell.h"
#import "JGCategoryItem.h"

@interface JGCategoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;


@end
@implementation JGCategoryCell

-(void)setItem:(JGCategoryItem *)item{
    _item = item ;
    _nameLabel.text = item.name ;
}
-(void)awakeFromNib{
    [super awakeFromNib] ;
    //取消系统默认选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    [self setSelected:YES animated:YES] ;
}

//设置分割线
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 2 ;
    [super setFrame:frame] ;
}


//cell选中的时候会来这个方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _indicatorView.hidden = !selected ;
    _nameLabel.textColor = selected?[UIColor redColor]:[UIColor blackColor] ;
    
}

@end
