//
//  JGBaseTopicView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGBaseTopicView.h"


@implementation JGBaseTopicView

+(instancetype)viewForXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject] ;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //解决视图自动拉伸问题
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
