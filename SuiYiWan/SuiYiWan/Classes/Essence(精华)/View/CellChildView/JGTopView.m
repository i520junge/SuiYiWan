//
//  JGTopView.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGTopView.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Date.h"
#import "UIImage+Randar.h"

@interface JGTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UILabel *textView;

@end

@implementation JGTopView
- (IBAction)clickMore:(UIButton *)sender {
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil] ;      //这个nil不能删除，是结束的标志，不然会一直循环无法结束
//    [sheet showInView:self] ;
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet] ;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }] ;
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }] ;
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }] ;
    [alertController addAction:action1] ;
    [alertController addAction:action2] ;
    [alertController addAction:action3] ;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil] ;
    
    
    
}



-(void)setItem:(JGTopicItem *)item{
    //系统方法，要加上这句，相当于_item = item
    [super setItem:item ];
    
    UIImage *placeholderImage = [UIImage imageWithBorderW:2 borderColor:[UIColor redColor] image:[UIImage imageNamed:@"jg"]] ;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //将获得的图片裁剪成圆形图片
        
            
            _iconView.image = [UIImage imageToRoundImageWithImage:image] ;
        
    }] ;

    
    
    _nameView.text = item.screen_name ;
    _textView.text = item.text ;
    
    //处理时间
    _timeView.text = [self timeStr] ;
}

//处理时间
-(NSString *)timeStr{
    NSString *str = self.item.create_time ;
    
    //1、请求下来的时间数据是字符串，将字符串转为这种样式yyyy-MM-dd hh:mm:ss的时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init ] ;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss" ;
    
    //将字符串按照设定的样式转成日期
    NSDate *creatDate = [formatter dateFromString:str] ;
    
    //2、获取发帖时间与当前时间在小时和分钟的差值
    NSDateComponents *creatDateCmp = [creatDate dateCompareWithNow] ;
    
    //3、判断今年（今天（>1小时内，>1分钟；<1分钟），昨天，昨天前；），非今年；
    if ([creatDate isThisYear]) {   //今年
        if ([creatDate isThisToday]) {  //今天
            
                    if (creatDateCmp.hour >= 1) {   //>1小时内
                        str = [NSString stringWithFormat:@"%zd小时前",creatDateCmp.hour] ;
                        
                    } else if(creatDateCmp.minute >= 1){      //>1分钟
                        str = [NSString stringWithFormat:@"%zd分钟前",creatDateCmp.minute] ;
                        
                    }else{      //刚刚
                        str = @"刚刚" ;
                    }
            
        } else if ([creatDate isThisYestoday]){ //昨天
            
            formatter.dateFormat = @"昨天 HH:mm" ;
            str = [formatter stringFromDate:creatDate] ;
            
        }else{  //昨天前
            
            formatter.dateFormat = @"MM-dd HH:mm:ss" ;
            str = [formatter stringFromDate:creatDate] ;    //把时间按照样式转为字符串
        }
    }
    
    return str ;
}
/*
 今年
 今天
 >1 小时
 2小时前
 
 >= 1 分钟
 1分钟前
 
 < 1分钟
 刚刚
 
 昨天
 昨天 14:30
 
 昨天之前
 10-23 14:37:20
 
 非今年
 2015-10-26 14:37:20
 */




@end
