//
//  JGTopicItem.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JGCommentItem;

//不同控制器的数据类型
typedef enum: NSInteger{
    JGTopicItemTypeAll = 1,
    JGTopicItemTypePicture = 10,
    JGTopicItemTypeVideo = 41,
    JGTopicItemTypeVocie = 31,
    JGTopicItemTypeText = 29
    
}JGTopicItemType;


@interface JGTopicItem : NSObject
/** 顶部View的模型数据 */
@property (nonatomic, strong) NSString *profile_image;
@property (nonatomic, strong) NSString *screen_name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *create_time;

/*
 中间图片View image0 is_gif width height
 */
@property (nonatomic, strong) NSString *image2;
@property (nonatomic, assign) BOOL is_gif;      //是否是GIF图
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) JGTopicItemType type;
@property (nonatomic, assign) BOOL isBigPicture ;   //记载是否是大图

/*
 中间视频的View
 */
@property (nonatomic, strong) NSString *videouri;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, strong) NSString *playcount;

/*
 中间声音的View
 */
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, assign) NSInteger voicetime;

/*
 处理最热评论数据：top_cmt
 */
// 字典数组（最热评论字典数组） => 有且只有一个
@property (nonatomic, strong) NSArray *top_cmt;
@property (nonatomic, strong)JGCommentItem *topComment;

/*
 底部View属性 cai ding comment repost
 */
@property (nonatomic, assign) CGFloat cai;
@property (nonatomic, assign) CGFloat ding;
@property (nonatomic, assign) CGFloat comment;
@property (nonatomic, assign) CGFloat repost;

//让模型专注数据的转换，不要出现数据以外的东西
//@property(nonatomic,assign)CGRect topViewFrame;
//@property(nonatomic,assign)CGFloat cellH;



@end
