//
//  JGSubTagItem.h
//  SuiYiWan
//
//  Created by 刘军 on 16/10/19.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGSubTagItem : NSObject

/**
 图片URL
 */
@property (nonatomic, strong) NSString *image_list;

/**
 订阅人数
 */
@property (nonatomic, strong) NSString *sub_number;

/**
 题目
 */
@property (nonatomic, strong) NSString *theme_name;

@end
