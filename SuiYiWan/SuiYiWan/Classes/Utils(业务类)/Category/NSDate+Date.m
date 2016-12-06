//
//  NSDate+Date.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/27.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate (Date)

//判断是否是今年
//1、拿到调用者日期的年份
//2、拿到当前时间的年份
//3、比较是否相等，返回BOOL值
-(BOOL)isThisYear{  //用对象方法外面比较好使用
    NSCalendar *calendar = [NSCalendar currentCalendar] ;   //获取日期对象
    
    //1、从调用者日期中，拿到调用者日期的年份
    NSDateComponents *creatCmp = [calendar components:NSCalendarUnitYear fromDate:self] ;
    
    //2、从当前日期中，拿到当前时间的年份
    NSDate *curDate = [NSDate date] ;   //获取当前日期
    NSDateComponents *curDateCmp = [calendar components:NSCalendarUnitYear fromDate:curDate] ;
    
    //3、比较年份是否相等，返回BOOL值
    return creatCmp.year == curDateCmp.year;
}

//判断是否是今天
-(BOOL)isThisToday{
    NSCalendar *calendar = [NSCalendar currentCalendar] ;   //获取日期对象
    return [calendar isDateInToday:self] ;
}

//判断是否是昨天
-(BOOL)isThisYestoday{
    NSCalendar *calendar = [NSCalendar currentCalendar] ;   //获取日期对象
    return [calendar isDateInYesterday:self] ;
}

//调用者日期和当前时间的差值，小时和分钟的差值
-(NSDateComponents *)dateCompareWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar] ;   //获取日期对象
    return [calendar components:NSCalendarUnitMinute|NSCalendarUnitHour fromDate:[NSDate date] toDate:self options:NSCalendarWrapComponents] ;
}

@end
