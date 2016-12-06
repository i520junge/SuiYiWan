//
//  JGFootRefreshView.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/29.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGFootRefreshView : UIView
+(instancetype)footRefreshView ;

/**
 提供接口供外面修改内部子控件隐藏或显示
 */
@property(nonatomic,assign)BOOL isUpRefresh;
@end
