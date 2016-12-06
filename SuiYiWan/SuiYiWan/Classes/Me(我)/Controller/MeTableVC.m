//
//  MeTableVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/15.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "MeTableVC.h"
#import "JGSettingVC.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "AFHTTPSessionManager+Manager.h"
#import "JGSquareItem.h"
#import "JGSquareCell.h"
#import <SafariServices/SafariServices.h>
#import "JGWebViewController.h"
#import "FriendTrendVC.h"
#import <SVProgressHUD.h>

static NSString *const ID = @"cell" ;
NSInteger cols = 4 ;    //一行4列
CGFloat margin = 1 ;    //每列和行的间距

/** cell的宽高 */
#define KitemWH  ((JGScreenW - (cols - 1)*margin)/cols)

@interface MeTableVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray *square_list;
@property(nonatomic,weak)UICollectionView *collectionView;
@end

@implementation MeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JGCommonBgColor ;
    //设置导航条
    [self setUpNavigationBar] ;
    
    //设置尾部视图为collectionView
    [self setUpFooterView] ;
    
        //加载数据
        [self loadData] ;
        
    
    //设置分组的样式
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10 ;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0  ) ;     //25是第一组的Y值35减10所得
    
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated] ;
//    JGLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset)) ;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
//    JGLog(@"%lf",cell.JG_y) ;
//}

#pragma mark - 加载数据
-(void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载数据……"] ;
    
//    1、创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager jg_manager] ;
    
//    2、拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary] ;
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
//    3、发送请求、解析数据
    [manager GET:JGBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss] ;
        //字典转模型
        _square_list = [JGSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]] ;
        
        //补齐缺口
        [self addData] ;
        
        //设置collectionView的高度
        NSInteger row = (_square_list.count - 1)/cols + 1 ;     //计算总行数，万能算法
        self.collectionView.JG_height = (KitemWH + 20)*row + (row - 1)*margin  ;
        self.tableView.tableFooterView = _collectionView ;      //一定要重新给tableFooterView重新赋值，不然高度会变回原来的300 ；

            //刷新表格
            [self.collectionView reloadData] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}

#pragma mark - 设置尾部视图
-(void)setUpFooterView{
    //低耦合，高内聚，用代码块去封装代码 --》 函数式编程
    //1、设置collectionView的布局方式为流水布局,必须设置，不然程序会蹦！
    UICollectionViewFlowLayout *flowlayout = ({
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init] ;
        CGFloat itemWH = (JGScreenW - (cols - 1)*margin)/cols ;
        flowlayout.itemSize = CGSizeMake(itemWH, itemWH + 20) ;  //设置每个cell的尺寸
        flowlayout.minimumInteritemSpacing = margin ;   //列间距
        flowlayout.minimumLineSpacing = margin ;    //行间距
        
        flowlayout ;    //整个函数会等于最后一个函数的值
    }) ;
    
    //2、创建collectionView
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowlayout] ;
        _collectionView = collectionView ;
        collectionView.backgroundColor = [UIColor clearColor] ;
        collectionView.dataSource = self ;
        collectionView.delegate = self ;
        //必须用注册的方式加载cell
        //    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID] ;
        [collectionView registerNib:[UINib nibWithNibName:@"JGSquareCell" bundle:nil] forCellWithReuseIdentifier:ID] ;
        
        //禁止掉回到顶部
        collectionView.scrollsToTop = NO ;
        
        collectionView ;
    }) ;
    
    self.tableView.tableFooterView = collectionView ;
}

//补齐缺口
-(void)addData{
    NSInteger extre = _square_list.count%cols ;
    if (extre) {
        //计算缺了几个
        extre = cols - extre ;
        for (int i = 0; i < extre; i ++) {
            JGSquareItem *item = [[JGSquareItem alloc] init] ;
            [_square_list addObject:item] ;     //添加空的模型
        }
    }
}

#pragma mark - collectionView的数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _square_list.count ;
}
-(JGSquareCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JGSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath] ;
    cell.squareItem = _square_list[indexPath.row] ;
    return cell ;
}


#pragma mark - 导航条
-(void)setUpNavigationBar{
    //导航条中间内容
    self.navigationItem.title = @"我的" ;
    
    //右边 设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" highImageName:@"mine-setting-icon-click" target:self action:@selector(settingClick:)] ;
    
    //右边 黑夜按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" selectImageName:@"mine-moon-icon-click" target:self action:@selector(moonClick:)] ;
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem] ;
}

/* 点击设置按钮 */
-(void)settingClick:(UIButton *)settingBtn{
    JGSettingVC *settingVC = [[JGSettingVC alloc] init] ;
    [self.navigationController pushViewController:settingVC animated:YES] ;
}

-(void)moonClick:(UIButton *)moonBtn{
    moonBtn.selected = !moonBtn.selected ;
}


#pragma mark - collectionView代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JGSquareItem *item = _square_list[indexPath.row] ;
    
    if ([item.url containsString:@"http://"] || [item.url containsString:@"https://"]) {
        
        //版本适配
        if (JGSystemVersion >= 9.0) {
            //        方法一：用SFSafariViewController，只适配iOS9.0以上版本
            SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]] ;
            [self presentViewController:safariVC animated:YES completion:nil] ;
            
        }else if (JGSystemVersion >= 8.0){
            
            //方法二：WKWebView，适配iOS8.0以上
            JGWebViewController *webVC = [[JGWebViewController alloc] init] ;
            webVC.url = [NSURL URLWithString:item.url];
            [self.navigationController pushViewController:webVC animated:YES] ;
        }
    }
    
}
#pragma mark - collectionView代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FriendTrendVC *vc = [[FriendTrendVC alloc] init] ;
        [self.navigationController pushViewController:vc animated:YES] ;
    }
}


@end
