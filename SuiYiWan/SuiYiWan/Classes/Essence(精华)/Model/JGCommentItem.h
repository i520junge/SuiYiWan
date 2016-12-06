//
//  JGCommentItem.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/26.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JGUserItem;

@interface JGCommentItem : NSObject
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, strong) NSString *voicetime;
@property (nonatomic, strong) NSString *content;

/**
 评论用户信息
 */
@property(nonatomic,strong)JGUserItem *user;

/**
拼接文字评论：用户名+评论内容
 */
@property(nonatomic,strong)NSString *totalContent;
@end
