//
//  JGRecommentVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGRecommentVC.h"
#import <AFNetworking.h>
#import "AFHTTPSessionManager+Manager.h"
#import <MJExtension/MJExtension.h>
#import "JGCategoryCell.h"
#import "JGUserCell.h"
#import "JGCategoryItem.h"
#import "JGUserItem.h"
#import <MJRefresh/MJRefresh.h>

static NSString *const categoryID = @"categoryID" ;
static NSString *const userID = @"userID" ;

@interface JGRecommentVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property(nonatomic,strong)NSArray *categorys;
@property(nonatomic,strong)NSArray *users;
@property(nonatomic,strong)JGCategoryItem *selectedCategory;

@property(nonatomic,weak) AFHTTPSessionManager *manager;

@end

@implementation JGRecommentVC
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager jg_manager] ;
    }
    return _manager ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注" ;
    self.view.backgroundColor = JGCommonBgColor ;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    //设置TableView的代理
    [self setUpTableView] ;
    
    //加载数据
    [self loadCategoryData] ;
    
    //添加上下拉刷新控件
    [self setUpRefreshView] ;
}


//设置TableView的代理
-(void)setUpTableView{
    _categoryTableView.dataSource = self ;
    _categoryTableView.delegate = self ;
    [_categoryTableView registerNib:[UINib nibWithNibName:@"JGCategoryCell" bundle:nil] forCellReuseIdentifier:categoryID] ;
    _categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) ;
    
    _userTableView.dataSource = self ;
    _userTableView.delegate = self ;
    _userTableView.backgroundColor = JGCommonBgColor ;
    [_userTableView registerNib:[UINib nibWithNibName:@"JGUserCell" bundle:nil] forCellReuseIdentifier:userID] ;
    _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _userTableView.contentInset = _categoryTableView.contentInset ;
}
-(void)setUpRefreshView{
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUserData)] ;
    header.automaticallyChangeAlpha = YES ;
    _userTableView.mj_header = header ;
    
    //上拉加载更多
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserData)] ;
    footer.automaticallyHidden = YES ;
    _userTableView.mj_footer = footer ;
    
    
}

#pragma mark - 加载数据
//加载左侧数据
-(void)loadCategoryData{
//    1、创建网络管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager jg_manager];
    
//    2、拼接数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
//    3、发送请求，解析数据
    JGWeakSelf ;
    [mgr GET:JGBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        //服务器数据和关键字冲突：转模型之前告诉框架，将ID替换成id
        [JGCategoryItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }] ;
        _categorys = [JGCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]] ;
        [_categoryTableView reloadData] ;
        
        //一进来主动去加载第一个分类的用户数据
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0] ;
        [weakSelf tableView:_categoryTableView didSelectRowAtIndexPath:index] ;
        
        //一进来就对_categoryTableView的cell进行选中一下，让它处于选中状态
        [_categoryTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone] ;
        
  
    } failure:nil] ;
}

//加载新的用户数据
-(void)loadNewUserData{
    //取消之前所有请求任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)] ;
    
    //一进来给页码赋值
    _selectedCategory.page = 1 ;
    
    //    1、创建网络管理者
    
    //    2、拼接数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    
    //通过选中ID分类，获取这个ID的数据
    parameters[@"category_id"] = _selectedCategory.ID ;
    
    //    3、发送请求，解析数据
    [self.manager GET:JGBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        //记录一下当前类的总页码数，将字符转为数字
        _selectedCategory.total_page = [responseObject[@"total_page"] integerValue] ;
        
        //数据加载成功记录一下页码
        _selectedCategory.page++ ;
        
        //结束下拉刷新
        [_userTableView.mj_header endRefreshing] ;
        
        _selectedCategory.users = [JGUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]] ;
        [_userTableView reloadData] ;
        
        //超出总页码隐藏刷新控件。
        _userTableView.mj_header.hidden = _selectedCategory.page > _selectedCategory.total_page ;
        
        
    } failure:nil] ;
}

//加载新的用户数据
-(void)loadMoreUserData{
    //取消之前所有请求任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)] ;
    
    //    1、创建网络管理者
    //    2、拼接数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    
    //通过选中ID分类，获取这个ID的数据
    parameters[@"category_id"] = _selectedCategory.ID ;
    
    //通过页码去取这页的数据
    parameters[@"page"] = @(_selectedCategory.page) ;
    
    //    3、发送请求，解析数据
    [self.manager GET:JGBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        //加载数据成功，页码记录一下
        _selectedCategory.page++ ;
        
        //结束刷新
        [_userTableView.mj_footer endRefreshing] ;
        //结束刷新
        [_userTableView.mj_header endRefreshing] ;
        
        NSArray *arr = [JGUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]] ;
        [_userTableView reloadData] ;
        //将加载出来的更多数据加到数组后面，一定要用addObjectsFromArray，将数组中元素一个个添加进去
        [_selectedCategory.users addObjectsFromArray:arr] ;
        
        //超出当前类总页码数，隐藏上拉刷新
        _userTableView.mj_footer.hidden = _selectedCategory.page > _selectedCategory.total_page ;
        
    } failure:nil] ;
}

#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _categoryTableView) return _categorys.count ;
    return  _selectedCategory.users.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _categoryTableView) {
        JGCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID] ;
        cell.item = _categorys[indexPath.row] ;
        return cell ;
    }
    
    JGUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID] ;
    cell.userItem = _selectedCategory.users[indexPath.row] ;
    return cell ;
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _categoryTableView) {
        //记录当前选择的是哪个分类，且将当前用户数据暂时保存在users数组中，相当于保存在缓存中
        _selectedCategory = _categorys[indexPath.row] ;
        [_userTableView reloadData] ;
        
        //刚开始要判断一次页码是否超出总页数，防止有的只有一页也显示上拉刷新控件
        _userTableView.mj_footer.hidden = _selectedCategory.page >= _selectedCategory.total_page ;
        
        //没有用户时才去加载用户数据，有的话就直接拿现有的展示数据，
        if (!_selectedCategory.users.count) {
            [_userTableView.mj_header beginRefreshing] ;
            //刷新新的数据不需要显示上拉刷新控件
            _userTableView.mj_footer.hidden = YES ;
        }
        
        //
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _categoryTableView) return 44 ;
    return 66 ;
}

@end
