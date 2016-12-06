//
//  FriendTrendVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/15.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "FriendTrendVC.h"
#import "JGRecommentVC.h"
#import "JGLoginRegisterVC.h"

@interface FriendTrendVC ()

@end

@implementation FriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JGCommonBgColor ;
    //设置导航条
    [self setUpNavigationBar] ;
    
}
-(void)setUpNavigationBar{
    //导航条中间内容
    self.navigationItem.title = @"我的关注" ;
    
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highImageName:@"friendsRecommentIcon-click" target:self action:@selector(recommentClick)] ;
    
}

//订阅按钮
-(void)recommentClick{
    JGRecommentVC *recommentVC = [[JGRecommentVC alloc] init] ;
    [self.navigationController pushViewController:recommentVC animated:YES] ;
}

//点击登录按钮
- (IBAction)loginClick:(UIButton *)sender {
    
    JGLoginRegisterVC *loginRegisterVC = [[JGLoginRegisterVC alloc] init] ;
    [self presentViewController:loginRegisterVC animated:YES completion:nil] ;
    
}

@end
