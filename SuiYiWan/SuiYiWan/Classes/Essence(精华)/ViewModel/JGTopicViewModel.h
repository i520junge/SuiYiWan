//
//  JGTopicViewModel.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JGTopicItem ;

@interface JGTopicViewModel : NSObject
@property(nonatomic,strong)JGTopicItem *item;

/**
 顶部View的frame
 */
@property(nonatomic,assign)CGRect topViewFrame;
@property(nonatomic,assign)CGFloat cellH;

/**
中间View的frame
 */
@property(nonatomic,assign)CGRect middleViewFrame;

/**
 最热评论view的frame
 */
@property(nonatomic,assign)CGRect commentViewFrame;

@property(nonatomic,assign)CGRect bottomViewFrame;
@end
