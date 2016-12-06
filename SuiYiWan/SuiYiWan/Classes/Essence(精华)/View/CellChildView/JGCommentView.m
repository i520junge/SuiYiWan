//
//  JGCommentView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/26.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGCommentView.h"
#import "JGCommentItem.h"
#import "JGUserItem.h"
#import "JGTopicItem.h"

@interface JGCommentView ()

/**
 文字评论：评论者+评论的内容
 */
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

/**
 声音评论view：评论者，语音
 */
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation JGCommentView
-(void)setItem:(JGTopicItem *)item{
    [super setItem:item] ;
    
    if (item.topComment.content.length) {   //文字评论
        _totalLabel.hidden = NO ;
        _voiceView.hidden = YES ;
        
        _totalLabel.text = item.topComment.totalContent ;
    }else{                                                      //语音评论
        _totalLabel.hidden = YES ;
        _voiceView.hidden = NO ;
        
        _nameLabel.text = item.topComment.user.username ;
        [_voiceButton setTitle:item.topComment.voicetime forState:UIControlStateNormal] ;
    }
    
    
}


@end
