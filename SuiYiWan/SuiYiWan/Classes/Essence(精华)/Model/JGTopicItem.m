//
//  JGTopicItem.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGTopicItem.h"
#import "JGCommentItem.h"
#import <MJExtension/MJExtension.h>

@implementation JGTopicItem
//-(void)setTop_cmt:(NSArray *)top_cmt{
//    _top_cmt = top_cmt ;
//    if (_top_cmt.count) {
//        //给topComment赋值,只需要第一条评论
//        NSDictionary *dict = top_cmt.firstObject ;
//        _topComment = [JGCommentItem mj_objectWithKeyValues:dict] ;
//        
//    }
//}


//只要遇到字典里有数组，数组里有字典，要告诉数组对应哪个模型
+(NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt":@"JGCommentItem"} ;
}
-(void)setTop_cmt:(NSArray *)top_cmt{
    _top_cmt = top_cmt ;
    if (top_cmt.count) {
        //给topComment赋值,只需要第一条评论
        _topComment = top_cmt.firstObject ;
        
    }
}

@end
