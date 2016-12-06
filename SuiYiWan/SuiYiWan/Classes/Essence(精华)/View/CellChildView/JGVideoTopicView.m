//
//  JGVideoTopicView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGVideoTopicView.h"
#import <UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>

@interface JGVideoTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UIButton *playMvBtn;

@end
@implementation JGVideoTopicView


-(void)setItem:(JGTopicItem *)item{
    [super setItem:item ];
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image2]] ;
    
    _playCountView.text = [NSString stringWithFormat:@"%@播放",item.playcount] ;
    
    
    NSInteger second = item.videotime % 60 ;
    NSInteger mimute = item.videotime/60 ;
    _timeView.text = [NSString stringWithFormat:@"%02ld:%02ld",mimute,second] ;
  
}
- (IBAction)playMvClick:(UIButton *)sender {
    //创建视频播放控制器
    MPMoviePlayerViewController *mvVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.item.videouri]] ;
    //弹出视频播放控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:mvVC] ;
}

@end
