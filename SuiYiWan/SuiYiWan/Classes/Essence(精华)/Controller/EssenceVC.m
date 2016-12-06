//
//  EssenceVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/15.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "EssenceVC.h"

@interface EssenceVC ()

@end

@implementation EssenceVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setUpNavigationBar] ;
    
    //添加所有子控制器
    [self setUpAllchildViewController] ;
}

//    3、添加所有子控制器
-(void)setUpAllchildViewController{
    NSArray *childVcName = @[
                             @"JGAllViewController",
                             @"JGVideoTableViewController",
                             @"JGVoiceTableViewController",
                             @"JGPictureTableViewController",
                             @"JGTextTableViewController"
                             ];
    NSArray *childVcTitle = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    for (int i = 0; i < childVcName.count; i++) {
        NSString *name = childVcName[i] ;
        //NSClassFromString可以通过类名创建类
        UITableViewController *vc = [[NSClassFromString(name) alloc] init] ;
        vc.title = childVcTitle[i] ;
        [self addChildViewController:vc] ;
    }
}



#pragma mark - 设置导航条
-(void)setUpNavigationBar{
    //导航条中间内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]] ;
    
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_item_game_icon" highImageName:@"nav_item_game_click_icon" target:self action:@selector(game)] ;
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationButtonRandom" highImageName:@"navigationButtonRandomClick" target:nil action:nil] ;
    
}
-(void)game{
    
}

@end
