//
//  JGCategoryItem.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/31.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGCategoryItem : NSObject

/**
 每个类名字
 */
@property(nonatomic,strong)NSString *name;

/**
 类的ID，用于加载这个类的用户
 */
@property(nonatomic,strong)NSString *ID;

/**
 用户总页数
 */
@property(nonatomic,assign)NSInteger total_page;

/**
 用于记录加载数据的页码
 */
@property(nonatomic,assign)NSInteger page;


/**
 用于保存userItem
 */
@property(nonatomic,strong)NSMutableArray *users;
@end
