//
//  JGBackView.h
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGBackView : UIView

/**
 导航条的返回按钮

 @param normalImageName 正常状态图片
 @param highImageName   高亮状态图片
 @param normalTitle     正常状态文字
 @param highTitle       高亮状态文字
 @param target          监听对象
 @param action          触发事件

 @return 返回一个返回按钮
 */
+(instancetype)backViewWithBtnNormalImageName:(NSString *)normalImageName highImageName:(NSString *)highImageName normalTitle:(NSString *)normalTitle highTitle:(NSString *)highTitle target:(id)target action:(SEL)action ;

@end
