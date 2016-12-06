//
//  JGBaseTableViewController.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/26.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGBaseTableViewController.h"
#import "JGTopicCell.h"
#import <AFNetworking.h>
#import "AFHTTPSessionManager+Manager.h"
#import <MJExtension/MJExtension.h>
#import "JGTopicViewModel.h"
#import <SVProgressHUD.h>
#import <MJRefresh/MJRefresh.h>

static NSString *const ID = @"cell" ;

@interface JGBaseTableViewController ()
@property(nonatomic,strong)NSMutableArray *topicVM;
/**
 记录下一页最大ID
 */
@property(nonatomic,strong)NSString *maxtime;

/**
 原始内边距
 */
@property(nonatomic,assign)UIEdgeInsets oriEdgeInsets;

@property(nonatomic,strong)AFHTTPSessionManager *maneger;

@end

@implementation JGBaseTableViewController
//懒加载，防止上拉、下拉数据冲突
-(AFHTTPSessionManager *)maneger{
    if (!_maneger) {
        _maneger = [AFHTTPSessionManager jg_manager] ;
    }
    return _maneger ;
}


-(JGTopicItemType)type{
    return JGTopicItemTypeAll ;
}

-(NSMutableArray *)topicVM{
    if (!_topicVM) {
        _topicVM = [NSMutableArray array] ;
    }
    return _topicVM ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //tableView的背景颜色
    self.tableView.backgroundColor = JGCommonBgColor ;
    
    [self.tableView registerClass:[JGTopicCell class] forCellReuseIdentifier:ID];
    
    // 告诉tableView所有cell的估算高度
    self.tableView.estimatedRowHeight = 100;
    
    //加载数据
    [self loadData] ;
    
    [SVProgressHUD showWithStatus:@"在努力加载数据中……"] ;
    
    //滚动条的上边距和下边距
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(99, 0, 49, 0) ;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    _oriEdgeInsets = UIEdgeInsetsMake(99, 0, 49, 0) ;
    
    //添加上、下拉刷新视图
    [self setUpRefreshView] ;
    
    //监听tabBar重复点击的通知，接受了通知，一定要销毁
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"repeatClickTab" object:nil] ;
    
    
}

//提供方法，让重复点击按钮刷新数据
-(void)reloadData{
    //判断当前重复点击的控制器是哪个，就是显示在窗口的控制器，只有显示在窗口的控制器才能拿到窗口
    if (self.view.window) {
        [self.tableView.mj_header beginRefreshing] ;
    }
}


#pragma mark - 添加上下拉刷新
-(void)setUpRefreshView{
    //下拉刷新步骤：
//    1、创建下拉控件
//    2、根据拖拽，自动显示下拉控件
//    3、添加下拉控件
//    4、加载数据成功结束刷新
    NSMutableArray *arr = [NSMutableArray array] ;
    for (int i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]] ;
        [arr addObject:image] ;
    }
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)] ;
    [header setImages:arr duration:0.5 forState:MJRefreshStatePulling] ;        //将一组图片传进去
    header.automaticallyChangeAlpha = YES ;     //拖拽时才显示下拉控件
    self.tableView.mj_header = header ;
    
    //添加上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)] ;
    footer.automaticallyHidden = YES ;      //自动根据有无数据，判断上拉控件是否完全显示
    self.tableView.mj_footer = footer ;
    
}


#pragma mark - 加载新数据和更多数据
-(void)loadData{
    //防止上拉刷新又下拉刷新冲突，在下拉刷新之前取消之前的所有请求
    [self.maneger.tasks makeObjectsPerformSelector:@selector(cancel)] ;
    
    //    1、创建会话管理者
    //    2、拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    
    //判断，如果是新帖，用a去取newlist，parentViewController是父控制器
    NSString *a = @"list" ;
    if ([self.parentViewController isKindOfClass:NSClassFromString(@"NewVC")]) {
        a = @"newlist" ;
    }
    
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
   
    //    3、发送请求,解析数据
    JGWeakSelf ;    //防止block对self强引用造成内存泄漏
    [self.maneger GET:JGBaseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //加载数据成功时，结束刷新控件
        [self.tableView.mj_header endRefreshing] ;
        
        //刷新新数据的时候记录下一页最大ID，以便上拉刷新获得更多数据时传给服务器获得下一页数据用
        _maxtime = responseObject[@"info"][@"maxtime"] ;
        
        
        NSArray *topicArr = [JGTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]] ;
        
        //计算cell上子控件的高度---> cell的高度
        NSMutableArray *arr = [NSMutableArray array] ;
        for (JGTopicItem *item in topicArr) {
            JGTopicViewModel *VM = [[JGTopicViewModel alloc] init] ;
            //计算cell的高度
            VM.item = item ;
            [arr addObject:VM] ;
        }
        weakSelf.topicVM = arr ;
        
        
        //加载数据成功，恢复悬停
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.contentInset = _oriEdgeInsets ;
        }] ;
        
        [SVProgressHUD dismiss] ;
        
        [weakSelf.tableView reloadData] ;
        
        
    } failure:nil] ;
    
}
-(void)loadMoreData{
    //防止下拉刷新又上拉刷新冲突，在上拉刷新之前取消之前的请求
    [self.maneger.tasks makeObjectsPerformSelector:@selector(cancel)] ;
    
    //    1、创建会话管理者
    //    2、拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    //通过加载新数据中获得的maxtime来获取下一页的数据
    parameters[@"maxtime"] = _maxtime ;
    
    //    3、发送请求,解析数据
    JGWeakSelf ;    //防止block对self强引用造成内存泄漏
    [self.maneger GET:JGBaseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing] ;
        
        //刷新新数据的时候记录下一页最大ID，以便上拉刷新获得更多数据时传给服务器获得下一页数据用
        _maxtime = responseObject[@"info"][@"maxtime"] ;
        
        
        
        NSArray *topicArr = [JGTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]] ;
        
        //计算cell上子控件的高度---> cell的高度
        for (JGTopicItem *item in topicArr) {
            JGTopicViewModel *VM = [[JGTopicViewModel alloc] init] ;
            //计算cell的高度
            VM.item = item ;
            [weakSelf.topicVM addObject:VM] ;
        }
        [SVProgressHUD dismiss] ;
        
        [weakSelf.tableView reloadData] ;
        
        
    } failure:nil] ;
}


#pragma mark - Tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicVM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //这个方法底层实现：去缓存池中看有没有绑定了ID的cell，有就取出来，没有就调用cell的initWithStyle方法去添加cell的子控件
    JGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.vm = self.topicVM[indexPath.row] ;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JGTopicViewModel *vm = self.topicVM[indexPath.row] ;
    return vm.cellH + 10 ;      //不会分割线的高度
}

//控制器销毁的时候，要移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES] ;
    [SVProgressHUD dismiss] ;
}

@end
