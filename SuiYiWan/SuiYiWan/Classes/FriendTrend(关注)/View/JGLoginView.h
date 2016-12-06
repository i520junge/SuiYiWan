//
//  JGLoginView.h
//  SuiYiWan
//
//  Created by 刘军 on 16/10/20.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGLoginView : UIView

/**
 加载登录界面

 @return 返回一个登录界面
 */
+(instancetype)loginView ;

/**
 加载注册界面

 @return 返回一个注册界面
 */
+(instancetype)registerView ;
@end
