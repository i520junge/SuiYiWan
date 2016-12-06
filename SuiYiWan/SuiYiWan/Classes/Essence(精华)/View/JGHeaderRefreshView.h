//
//  JGHeaderRefreshView.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/29.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGHeaderRefreshView : UIView
+(instancetype)headerRefreshView ;
@property(nonatomic,assign)BOOL isDownRefresh;
@property(nonatomic,assign)BOOL isNeedToRefresh;
@end
