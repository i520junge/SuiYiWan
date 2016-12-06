//
//  JGFootRefreshView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/29.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGFootRefreshView.h"

@interface JGFootRefreshView ()
@property (weak, nonatomic) IBOutlet UILabel *upLabel;
@property (weak, nonatomic) IBOutlet UIView *refreshView;
@property (weak, nonatomic) IBOutlet UIImageView *upImageView;


@end
@implementation JGFootRefreshView
-(void)setIsUpRefresh:(BOOL)isUpRefresh{
    _isUpRefresh = isUpRefresh ;
    _upLabel.hidden = isUpRefresh ;
    _refreshView.hidden = !isUpRefresh ;
    
    //如果刷新则旋转180度，不刷新则恢复原来.。。注：防止零界点发生+0.00001
    _upImageView.transform = isUpRefresh?CGAffineTransformMakeRotation(-M_PI + 0.00001) :CGAffineTransformIdentity;
}

+(instancetype)footRefreshView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject] ;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //解决视图自动拉伸问题
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
