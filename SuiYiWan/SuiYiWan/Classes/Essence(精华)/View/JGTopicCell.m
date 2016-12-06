//
//  JGTopicCell.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGTopicCell.h"
#import "JGTopView.h"
#import "JGTopicItem.h"
#import "JGTopicViewModel.h"
#import "JGPictureTopicView.h"
#import "JGVideoTopicView.h"
#import "JGVoiceTopicView.h"
#import "JGCommentView.h"
#import "JGCommentItem.h"
#import "JGBottomView.h"

@interface JGTopicCell ()
/**
 顶部view
 */
@property(nonatomic,weak)JGTopView *topView;

/**
 中间view
 */
@property(nonatomic,weak)JGPictureTopicView *pictureView;   //图片
@property(nonatomic,weak)JGVideoTopicView *videoView;  //视频
@property(nonatomic,weak)JGVoiceTopicView *voiceView;  //声音

/**
 最热评论
 */
@property(nonatomic,weak) JGCommentView*commentView;

/**
 底部View
 */
@property(nonatomic,weak)JGBottomView *bottomView;

@end
@implementation JGTopicCell
//设置分割线
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10 ;
    frame.origin.y += 10 ;
    [super setFrame:frame] ;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //设置cell的背景图片
        UIImage *imge = [UIImage imageNamed:@"mainCellBackground"] ;
        //一定要将背景图片设置中间一点不是真拉伸，不然图片两边显示有黑色阴影
        imge = [imge stretchableImageWithLeftCapWidth:imge.size.width*0.5 topCapHeight:imge.size.height*0.5] ;
        [self setBackgroundView:[[UIImageView alloc] initWithImage:imge]] ;
        
        
        
        
        //顶部XIB
        JGTopView *topView = [JGTopView viewForXib] ;
        [self.contentView addSubview:topView] ;
        _topView = topView ;
        
        //中间XIB(视频，声音，图片)
        //图片
        JGPictureTopicView *pictureView = [JGPictureTopicView viewForXib] ;
        [self.contentView addSubview:pictureView] ;
        _pictureView = pictureView ;
        
        //视频
        JGVideoTopicView *videoView = [JGVideoTopicView viewForXib] ;
        [self.contentView addSubview:videoView] ;
        _videoView = videoView ;
        
        //声音
        JGVoiceTopicView *voiceView = [JGVoiceTopicView viewForXib] ;
        [self.contentView addSubview:voiceView] ;
        _voiceView = voiceView ;
        
        //最热评论
        JGCommentView *commentView = [JGCommentView viewForXib] ;
        [self.contentView addSubview:commentView] ;
        _commentView = commentView ;
        
        //底部view
        JGBottomView *bottomView = [JGBottomView viewForXib] ;
        [self.contentView addSubview:bottomView] ;
        _bottomView = bottomView ;
        
    }
    return self ;
}

-(void)setVm:(JGTopicViewModel *)vm{
    _vm = vm ;
    
    //顶部的View
    self.topView.item = vm.item;
    //设置XIB的frame
    self.topView.frame = vm.topViewFrame ;
    
    //中间view
    if (vm.item.type == JGTopicItemTypePicture) {   //图片
        _pictureView.item = vm.item ;
        _pictureView.frame = vm.middleViewFrame ;
        
        _pictureView.hidden = NO ;
        _videoView.hidden = YES ;
        _voiceView.hidden = YES ;
        
    }else if (vm.item.type == JGTopicItemTypeVideo){   //视频
        _videoView.item = vm.item ;
        _videoView.frame = vm.middleViewFrame ;
        
        _pictureView.hidden = YES ;
        _videoView.hidden = NO ;
        _voiceView.hidden = YES ;
        
    }else if (vm.item.type == JGTopicItemTypeVocie){   //声音
        _voiceView.item = vm.item ;
        _voiceView.frame = vm.middleViewFrame ;
        
        _pictureView.hidden = YES ;
        _videoView.hidden = YES ;
        _voiceView.hidden = NO ;
        
    }else{   //段子
        _pictureView.hidden = YES ;
        _videoView.hidden = YES ;
        _voiceView.hidden = YES ;
        
    }
    
    //设置评论view
    //如果有评论就显示，没有就隐藏
    if (vm.item.topComment) {
        _commentView.hidden = NO ;
        
        _commentView.item = vm.item ;
        _commentView.frame = vm.commentViewFrame ;
    }else{
        _commentView.hidden = YES ;
    }
    
    //底部view
    _bottomView.item = vm.item ;
    _bottomView.frame = vm.bottomViewFrame ;
}

@end
