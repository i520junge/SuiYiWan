//
//  JGSubTableVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/18.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGSubTableVC.h"
#import <AFNetworking.h>
#import "AFHTTPSessionManager+Manager.h"
#import <MJExtension.h>
#import "JGSubTagItem.h"
#import "JGTagCell.h"
#import <SVProgressHUD.h>


//static让变量只能在本文件使用且全局变量，const使变量变为常量，本文件中其他地方更改它会报错
static NSString *const ID = @"cell" ;

@interface JGSubTableVC ()
@property(nonatomic,strong)NSArray *tags;
@property(nonatomic,weak) AFHTTPSessionManager *manager;
@end

@implementation JGSubTableVC
//懒加载manager
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        //    1、开启会话管理
        AFHTTPSessionManager *manager = [AFHTTPSessionManager jg_manager] ;
        _manager = manager ;
    }
    return _manager ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //网络请求获取数据
    [self loadData] ;
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"JGTagCell" bundle:nil] forCellReuseIdentifier:ID] ;
    
    //取消系统分割线内边距，没数据的地方已经全屏分割线了，有数据的地方还是有一点点内边距
//    self.tableView.separatorInset = UIEdgeInsetsZero ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.backgroundColor =JGCommonBgColor ;
}

//控制器即将消失的时候
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated] ;
    //隐藏指示器
    [SVProgressHUD dismiss] ;
    
    //取消网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)] ;
}

#pragma mark - 网络请求获取数据
//网络请求获取数据
// 请求数据 => 查看接口(1.基本URL 2.请求方式 3.请求参数) => AFN => 解析数据 => 写成Plist => 设计模型 => 字典转模型
-(void)loadData{
    
    [SVProgressHUD showWithStatus:@"正在努力加载数据中……"] ;
//    1、开启会话管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager jg_manager] ;
    _manager = manager ;
//    2、拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
//    3、发送请求
    [self.manager GET:JGBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *responseObject) {
        [SVProgressHUD dismiss] ;
        
        //字典数组转模型
        _tags = [JGSubTagItem mj_objectArrayWithKeyValuesArray:responseObject] ;
        [self.tableView reloadData] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        [SVProgressHUD showErrorWithStatus:@"请查看您的网络"] ;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss] ;
        });
    }] ;
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JGTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    cell.layoutMargins = UIEdgeInsetsZero ;
    cell.tagItem = self.tags[indexPath.row] ;
    return cell;
}

#pragma mark - 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 + 1 ;
}


@end
