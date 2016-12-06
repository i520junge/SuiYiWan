//
//  JGVoiceTopicView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/26.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGVoiceTopicView.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>

@interface JGVoiceTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property(nonatomic,strong)AVPlayer *player ;
@property(nonatomic,weak)NSTimer *timer ;

@end
@implementation JGVoiceTopicView
-(AVPlayer *)player{
    if (!_player) {
        NSURL *url = [NSURL URLWithString:self.item.voiceuri] ;
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url] ;
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item] ;
        _player = player;
    }
    return _player;
}


-(void)setItem:(JGTopicItem *)item{
    [super setItem:item ];
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image2]] ;
//    _playCountView.text = [NSString stringWithFormat:@"%@播放",item.playcount] ;
    
    NSInteger second = item.voicetime % 60 ;
    NSInteger mimute = item.voicetime/60 ;
    _timeView.text = [NSString stringWithFormat:@"%02ld:%02ld",mimute,second] ;
    
}
- (IBAction)playVoiceClick:(UIButton *)sender {
    _playBtn.selected = !_playBtn.selected ;
    if (_playBtn.isSelected) {
        [self.player play] ;
    }else{
        [self.player pause] ;
    }
}

//-(void)startTimer{
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES] ;
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes] ;
//}
//
//
//-(void)updateTime{
//   
//}

@end
