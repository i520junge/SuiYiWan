//
//  JGTagCell.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/19.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGTagCell.h"
#import "JGSubTagItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Randar.h"

@interface JGTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end
@implementation JGTagCell

#pragma mark - 设置数据
-(void)setTagItem:(JGSubTagItem *)tagItem{
    _tagItem = tagItem ;
    _themeLabel.text = tagItem.theme_name ;
    
    //设置订阅人数
    CGFloat numble = [tagItem.sub_number floatValue] ;
    NSString *numStr = [NSString stringWithFormat:@"%zd人订阅",numble] ;
    if (numble > 10000) {
        numble = numble/10000.0 ;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numble] ;
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""] ;
        
    }
    _numberLabel.text = numStr ;
    
    //设置图片
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:tagItem.image_list] placeholderImage:[UIImage imageToRoundImageWithImage:[UIImage imageNamed:@"jg"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //将获得的图片裁剪成圆形图片
        _iconImageView.image = [UIImage imageToRoundImageWithImage:image] ;
    }] ;
    
}
+(instancetype)tagCell{
   return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject] ;
}

//重写cell的setFrame,设置全屏分割线
-(void)setFrame:(CGRect)frame{
//    JGLog(@"%@",NSStringFromCGRect(frame)) ;
    frame.size.height -= 1 ;
    [super setFrame:frame] ;
}



//-(void)layoutSubviews{
//    [super layoutSubviews] ;
//    _iconImageView.layer.cornerRadius = _iconImageView.JG_width * 0.5 ;
//    //超出主层就会剪切掉
//    _iconImageView.layer.masksToBounds = YES ;
//}


@end
