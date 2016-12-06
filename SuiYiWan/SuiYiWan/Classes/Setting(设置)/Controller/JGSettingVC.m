//
//  JGSettingVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGSettingVC.h"
#import <SDImageCache.h>
#import "JGFileManager.h"
#import <SVProgressHUD.h>

static NSString * const ID = @"cell" ;

@interface JGSettingVC ()

/**
 记录缓存大小
 */
@property(nonatomic,strong)NSString *str ;

@end

@implementation JGSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设     置" ;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID] ;
    [SVProgressHUD showWithStatus:@"正在计算缓存大小……"] ;
    
    [JGFileManager directorySizeString:KcachePath strCompletion:^(NSString *str) {
        [SVProgressHUD dismiss] ;
        _str = str ;
        [self.tableView reloadData] ;
    } ];
    
}



#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID] ;

        cell.textLabel.text = _str ;
    return cell ;
}

//点击清除缓存
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //移除给定路径的所有文件
    [JGFileManager removeDirectoryPath:KcachePath] ;
    
    _str = @"清除缓存" ;

    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle] ;
    self.view.userInteractionEnabled = NO ;
    [SVProgressHUD showSuccessWithStatus:@"清除成功"] ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss] ;
      
    });
}



-(void)dealloc{
    self.view.userInteractionEnabled = YES ;
    
}

@end
