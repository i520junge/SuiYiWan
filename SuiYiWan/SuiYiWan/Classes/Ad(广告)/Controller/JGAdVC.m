//
//  JGAdVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/18.
//  Copyright © 2016年 JunGe. All rights reserved.
//
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#import "JGAdVC.h"
#import <AFNetworking.h>
#import "AFHTTPSessionManager+Manager.h"
#import <MJExtension/MJExtension.h>
#import "JGAdItem.h"
#import <UIImageView+WebCache.h>
#import "JGTabBarController.h"

@interface JGAdVC ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *AdView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property(nonatomic,strong) JGAdItem *adItem;
@property(nonatomic,weak) NSTimer *timer;

@end

@implementation JGAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置启动图片
    [self setupLaunchImageView] ;
    
    //加载广告数据
    [self loadAdData] ;
}

//跳过按钮
- (IBAction)jumpClick:(UIButton *)sender {
    [_timer invalidate] ;
    _timer = nil ;
    JGTabBarController *tabBarVC = [[JGTabBarController alloc] init] ;
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC ;
}

-(void)loadAdData{
//    1、创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager jg_manager] ;
    
//    2、拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    parameters[@"code2"] = code2 ;
    
//    3、发送请求
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
//        JGLog(@"%@",responseObject) ;
        
        NSDictionary *adDict = [responseObject[@"ad"] firstObject] ;
        
        //将ad字典转模型
        _adItem = [JGAdItem mj_objectWithKeyValues:adDict] ;
        

        //将网络请求出来的URL图片下载，添加在AdView上
        UIImageView *imageView = [[UIImageView alloc] init] ;
            imageView.userInteractionEnabled = YES ;
        CGFloat H = 0 ;
        if (_adItem.w > 0) {    //防止除以的数为空值或0
        H = JGScreenW/_adItem.w * _adItem.h ;
        }
        imageView.frame = CGRectMake(0, 0, JGScreenW, H) ;
        //下载图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:_adItem.w_picurl]] ;
        [_AdView addSubview:imageView] ;
        
        //添加点按手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)] ;
            [imageView addGestureRecognizer:tap] ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        JGLog(@"%@",error) ;
    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerChange) userInfo:nil repeats:YES] ;
}

//每隔1秒执行
-(void)timerChange{
    static int i = 3 ;
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%zd)",i--] forState:UIControlStateNormal] ;
    if (i < -1) {
        [self jumpClick:nil] ;
    }
}

//当点击广告时
-(void)tap{
    //拿到URL
    NSURL *URL = [NSURL URLWithString:_adItem.ori_curl] ;
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL] ;
    }
}


#pragma mark - 设置启动图片
- (void)setupLaunchImageView
{
    // 根据屏幕去加载不同图片
    // 6P LaunchImage-800-Portrait-736h@3x
    // 6 LaunchImage-800-667h@2x
    
    // 6P: 736 6 : 667  5 : 568 4 : 480
    UIImage *image = nil;
    if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
    _launchImageView.image = image;
}


@end
