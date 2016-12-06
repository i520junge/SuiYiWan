//
//  UIBarButtonItem+Item.h
//  SuiYiWan
//
//  Created by 刘军 on 16/10/16.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

/**
 设置导航条左右按钮正常和高亮状态

 @param imageName     正常状态图片
 @param highImageName 高亮图片
 @param target        监听对象
 @param action        触发时间

 @return 返回UIBarButtonItem
 */
+(instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

/**
 设置导航条左右按钮正常和高亮状态
 
 @param imageName     正常状态图片
 @param selectImageName 被选中图片
 @param target        监听对象
 @param action        触发时间
 
 @return 返回UIBarButtonItem
 */
+(instancetype)itemWithImageName:(NSString *)imageName selectImageName:(NSString *)selectImageName target:(id)target action:(SEL)action ;
@end
