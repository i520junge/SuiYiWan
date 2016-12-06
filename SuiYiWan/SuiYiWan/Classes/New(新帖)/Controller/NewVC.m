//
//  NewVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/15.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "NewVC.h"
#import "JGSubTableVC.h"
#import "JGBaseTableViewController.h"

@interface NewVC ()

@end

@implementation NewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor] ;
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
                             @"JGTextTableViewController",
                             @"JGSettingVC"
                            
                             ];
    NSArray *childVcTitle = @[@"全部",@"视频",@"声音",@"图片",@"段子",@"设置"];
    
    for (int i = 0; i < childVcName.count; i++) {
        NSString *name = childVcName[i] ;
        //NSClassFromString可以通过类名创建类
        UITableViewController *vc = [[NSClassFromString(name) alloc] init] ;
        vc.title = childVcTitle[i] ;
        [self addChildViewController:vc] ;
    }
}

-(void)setUpNavigationBar{
    //导航条中间内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]] ;
    
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick" target:self action:@selector(subClick)] ;
    
    
}

//订阅按钮
-(void)subClick{
    JGSubTableVC *subVC = [[JGSubTableVC alloc] init] ;
    [self.navigationController pushViewController:subVC animated:YES] ;
}
@end
