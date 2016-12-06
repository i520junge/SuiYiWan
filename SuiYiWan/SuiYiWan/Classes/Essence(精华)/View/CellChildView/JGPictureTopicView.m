//
//  JGPictureTopicView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGPictureTopicView.h"
#import <DACircularProgress/DALabeledCircularProgressView.h>
#import "JGSeeBigPictureVC.h"
#import <UIImageView+WebCache.h>


@interface JGPictureTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;



@end
@implementation JGPictureTopicView
-(void)awakeFromNib{
    [super awakeFromNib] ;
    //关闭查看大图按钮与用户交互的能力，交给self
    _seeBigButton.userInteractionEnabled = NO ;
    
    _progressView.roundedCorners = 5;
    _progressView.progressLabel.textColor = [UIColor whiteColor] ;
    _progressView.progressLabel.text = @"0%" ;
}

//点击图片查看大图，这里用touchesEnded方法更好，不会太敏感，在拖动tableView的时候容易触发
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    JGSeeBigPictureVC *seePicture = [[JGSeeBigPictureVC alloc] init] ;
    
    //把当前模型传过去
    seePicture.item = self.item ;
    //modal出来
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seePicture animated:YES completion:nil] ;
    
}


-(void)setItem:(JGTopicItem *)item{
    [super setItem:item ];
    _gifView.hidden = !item.is_gif ;
    
    //下载图片，设置进度
//    JGWeakSelf ;    //有block回调，防止强引用，所以将self弱引用
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image2] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (expectedSize == -1) return ;
                CGFloat progress=1.0 *  receivedSize/expectedSize ;
        
                NSString *str = [NSString stringWithFormat:@"%.0f%%",progress*100] ;
        
        //不需要做线程通信，SD已经在block回调的时候做了线程通信
                _progressView.progress = progress ;
                _progressView.progressLabel.text = str ;

    } completed:nil] ;
    
    
    
    //处理大图
    _seeBigButton.hidden = !item.isBigPicture ;
    if (item.isBigPicture) {
        //如果是大图则让大图值显示200的高度，且图片置顶对齐，超出的裁剪掉
        _pictureView.contentMode = UIViewContentModeTop ;
        _pictureView.clipsToBounds = YES ;
    }else{
        //cell是循环复用的，必须这样处理
        _pictureView.contentMode = UIViewContentModeScaleToFill ;
        _pictureView.clipsToBounds = NO ;
    }
    
}


@end
