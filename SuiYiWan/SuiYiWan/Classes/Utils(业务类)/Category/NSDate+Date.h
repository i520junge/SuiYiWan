//
//  NSDate+Date.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/27.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Date)

/**
 判断是否是今年

 @return 返回BOOL值
 */
-(BOOL)isThisYear ;

/**
 判断是否是今天
 
 @return 返回BOOL值
 */
-(BOOL)isThisToday ;

/**
 判断是否是昨天
 
 @return 返回BOOL值
 */
-(BOOL)isThisYestoday ;

/**
 获取与当前时间的差值

 @return 小时和分钟的差值
 */
-(NSDateComponents *)dateCompareWithNow ;
@end
