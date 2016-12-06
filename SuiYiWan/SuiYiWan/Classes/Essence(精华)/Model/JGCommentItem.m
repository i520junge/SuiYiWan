//
//  JGCommentItem.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/26.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGCommentItem.h"
#import "JGUserItem.h"

@implementation JGCommentItem

-(NSString *)totalContent{
    return [NSString stringWithFormat:@"%@:%@",self.user.username,self.content] ;
}

@end
