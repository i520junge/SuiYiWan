//
//  JGTopicViewModel.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
// 所有的frame复杂逻辑计算都抽在这里. 让cell面向视图模型开发

#import "JGTopicViewModel.h"
#import "JGTopicItem.h"
#import "JGCommentItem.h"
#import "JGUserItem.h"

//正文字体大小
#define KtextFont [UIFont systemFontOfSize:17]

@implementation JGTopicViewModel
-(void)setItem:(JGTopicItem *)item{
    _item = item ;
    
//  1、      顶部View的frame
    CGFloat topX = 0 ;
    CGFloat topY = 0 ;
    CGFloat margin = 10 ;
    CGFloat topW = JGScreenW ;
    CGFloat textY = 55 ;
    CGFloat textW = JGScreenW - 2*margin ;
    
    //计算不确定文字的高度
    /**
     计算不确定文字数量的高度
     @param item.text label的text
     @param textW    约束label的宽度
     @param MAXFLOAT 高度无穷大

     @return 这个方法返回的是size，所以要.height
     */
//    CGFloat textH = [item.text sizeWithFont:KtextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height ;
    
    NSDictionary *textAttr = @{NSFontAttributeName : KtextFont};
    /**
        计算不确定文字数量的高度
        tem.text label的text
        textW    约束label的宽度
        MAXFLOAT 高度无穷大
        options： 是一个枚举，用NSStringDrawingUsesLineFragmentOrigin，根据行来确定
        attributes：传含有文字大小的字典，根据这个大小来计算高度
             
        这个方法返回的是size，所以要.height
     */
    CGFloat textH = [item.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size.height;
    
    
    CGFloat topH = textY +textH ;
    _topViewFrame = CGRectMake(topX, topY, topW, topH) ;
    _cellH = CGRectGetMaxY(_topViewFrame) + margin ;
    
//2、    中间View的frame（只有非段子才需要计算）
    if (item.type != JGTopicItemTypeText) {
        CGFloat middleX = margin ;
        CGFloat middleY = _cellH ;
        CGFloat middleW = textW ;       //图片距两边10
        CGFloat middleH = item.height/item.width * textW ;
        
        //处理大图
        if (middleH >= JGScreenH) {// 一旦图片的显示高度超过一个屏幕，就让图片高度为200
            middleH = 200 ;
            item.isBigPicture = YES ;
        }
        
        _middleViewFrame = CGRectMake(middleX, middleY, middleW, middleH) ;
        _cellH = CGRectGetMaxY(_middleViewFrame)  + margin;
        
    }
    
// 3、   计算最热评论view的frame
    if (item.topComment) {      //如果有评论就计算高度
        
    CGFloat commentX = 0 ;
    CGFloat commentY = _cellH ;
    CGFloat commentW = JGScreenW ;
    CGFloat commentH = 43 ;     //最热评论 + 用户名字label高度
    if (item.topComment.content.length) {   //文字评论
        CGFloat contentH = [item.topComment.totalContent boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size.height;
        commentH = 21 + contentH ;
    }
    _commentViewFrame = CGRectMake(commentX, commentY, commentW, commentH) ;
    _cellH = CGRectGetMaxY(_commentViewFrame) + margin ;
     }
    
//    4、计算底部view的高度
    CGFloat bottomX = 0;
    CGFloat bottomY = _cellH;
    CGFloat bottomW = JGScreenW;
    CGFloat bottomH = 35;
    _bottomViewFrame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    _cellH = CGRectGetMaxY(_bottomViewFrame);
    
}
@end
