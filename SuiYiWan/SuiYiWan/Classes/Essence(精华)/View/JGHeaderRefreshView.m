//
//  JGHeaderRefreshView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/29.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGHeaderRefreshView.h"

@interface JGHeaderRefreshView ()

@property (weak, nonatomic) IBOutlet UILabel *downLabel;
@property (weak, nonatomic) IBOutlet UIView *refreshView;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;

@end


@implementation JGHeaderRefreshView
-(void)setIsNeedToRefresh:(BOOL)isNeedToRefresh{
    _isNeedToRefresh = isNeedToRefresh ;
    
    _downLabel.text = isNeedToRefresh?@"松开立即刷新":@"下拉可以刷新" ;
    
    [UIView animateWithDuration:0.25 animations:^{
        _downImageView.transform = isNeedToRefresh ?CGAffineTransformMakeRotation(-M_PI + 0.00001):CGAffineTransformIdentity ;
        
    }] ;
    
}
-(void)setIsDownRefresh:(BOOL)isDownRefresh{
    _isDownRefresh = isDownRefresh ;
    _downImageView.hidden = isDownRefresh ;
    _downLabel.hidden = isDownRefresh ;
    _refreshView.hidden = !isDownRefresh ;
}



+(instancetype)headerRefreshView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject] ;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //解决视图自动拉伸问题
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
