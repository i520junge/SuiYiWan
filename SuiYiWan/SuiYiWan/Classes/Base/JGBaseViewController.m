//
//  JGBaseViewController.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/24.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGBaseViewController.h"
#import "JGBaseTableViewController.h"

static NSString *const ID = @"cell" ;
@interface JGBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,weak)UICollectionView *bottomCollectionView;
@property(nonatomic,weak)UIScrollView *topScrollView;
@property(nonatomic,weak)UIButton *selectBtn;
@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,assign)BOOL isInitial ;
/**
 标题下面的滚动线
 */
@property(nonatomic,weak) UIView *underLine;

@end

@implementation JGBaseViewController
-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array] ;
    }
    return _btns ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor] ;
    
    //    1、添加用于装子控制器view的view
    [self setUpBottomCollectionView] ;
    
    //    2、添加顶部标题
    [self setUpTopTitleView] ;
    
    //让view的顶部内边距为0
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
}

//    1、添加用于装子控制器view的view
-(void)setUpBottomCollectionView{
    //设置流水布局
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init] ;
        layout.itemSize = [UIScreen mainScreen].bounds.size ;
//        layout.minimumInteritemSpacing = 0 ;
        layout.minimumLineSpacing = 0 ;     //让cell之间没有间距
        //将其设置为水平排布，默认是垂直往下排布，
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
        layout ;
    }) ;
    
    //设置collectionView
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, JGScreenW, JGScreenH) collectionViewLayout:layout] ;
        collectionView.backgroundColor = [UIColor greenColor] ;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        collectionView.dataSource = self ;
        collectionView.delegate = self ;
        //iOS10.0后collectionView默认不会循环利用cell了，下面属性(预获取)设置为NO就可以循环利用了,但是这个属性只有iOS10.0后有，如果是以下版本，不适配
        if (JGSystemVersion >= 10.0) {
            collectionView.prefetchingEnabled = NO ;
        }
        //禁止掉collectionView回到顶部的功能
        collectionView.scrollsToTop = NO ;
        
        
        //让水平和垂直方向滚动条消失
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces = NO;    //滚动时有弹簧效果
        collectionView.pagingEnabled = YES;     //分页
        collectionView ;
    }) ;
    
    [self.view addSubview:collectionView] ;
    _bottomCollectionView = collectionView ;
    
}
//    2、添加顶部标题
-(void)setUpTopTitleView{
    CGFloat scrollViewY = self.navigationController.navigationBarHidden ==YES?20:64 ;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, JGScreenW, 35)] ;
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    scrollView.showsHorizontalScrollIndicator = NO ;
    [self.view addSubview:scrollView] ;
    _topScrollView = scrollView ;
    
    //禁止掉这个scrollView回到顶部的功能
    scrollView.scrollsToTop = NO ;
}


#pragma mark - 添加标题按钮
//只有等控制器添加了，才能计算标题按钮
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    
    //为防止标题按钮被添加多次
    if (!_isInitial) {
        //    4、给标题添加按钮
        [self setupAllTitleButton] ;
        _isInitial = YES ;
    }
}
//    4、给标题添加按钮
-(void)setupAllTitleButton{
    NSInteger count = self.childViewControllers.count ;
    CGFloat btnX = 0 ;
    CGFloat btnH = _topScrollView.JG_height ;
    CGFloat btnW = _topScrollView.JG_width/count ;
    if (count > 5) {
        btnW = 100 ;
        _topScrollView.contentSize = CGSizeMake(btnW*count, 0) ;
    }
    for (int i = 0; i < count; i++) {
        btnX = btnW*i ;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        btn.tag = i ;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH) ;
        UIViewController *vc = self.childViewControllers[i] ;
        [btn setTitle:vc.title forState:UIControlStateNormal] ;
        btn.titleLabel.font = [UIFont systemFontOfSize:15] ;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_topScrollView addSubview:btn] ;
        
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //将按钮放到数组中，方便拿
        [self.btns addObject:btn] ;
        
        //设置一加载就选中第一个控制器
        if (i == 0) {
            //添加下划线
            [self setUpUnderLine:btn] ;
            
            [self titleClick:btn] ;
            
        }
    }
}

-(void)titleClick:(UIButton *)btn{
    
    //重复点击按钮，进行刷新数据
    NSInteger i = btn.tag ;
    if (btn == _selectBtn) {
        JGBaseTableViewController *VC = self.childViewControllers[i] ;  //谁调用就拿谁的子控制器
        [VC reloadData] ;
    }
    
    //偏移到对应的位置
    CGFloat offsetX = btn.tag * JGScreenW ;
    _bottomCollectionView.contentOffset = CGPointMake(offsetX, 0) ;
    
    [self setTitleSelBtn:btn] ;
}

//选中标题按钮
-(void)setTitleSelBtn:(UIButton *)btn{
    self.selectBtn.selected = NO ;
    btn.selected = YES ;
    self.selectBtn = btn ;
    
    //移动下划线
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        _underLine.JG_centerX = btn.JG_centerX ;
    } completion:nil] ;
}

//添加下划线
-(void)setUpUnderLine:(UIButton *)btn{
    UIView *underLine = [[UIView alloc] init] ;
    underLine.backgroundColor = [UIColor redColor] ;
    [btn.titleLabel sizeToFit] ;    //此时btn.titleLabel还没有加载上去，所以下面拿不到它的宽度
    underLine.JG_height = 2 ;
    underLine.JG_width = btn.titleLabel.JG_width ;
    underLine.JG_centerX = btn.JG_centerX ;
    underLine.JG_y = _topScrollView.JG_height - underLine.JG_height ;
    [_topScrollView addSubview:underLine] ;
    _underLine = underLine ;

}

#pragma mark - UICollectionView数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 每次只要有新的cell出现就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //移除之前的子控制器
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)] ;
    
    //添加子控制到cell中
    UITableViewController *vc = self.childViewControllers[indexPath.row] ;
    //防止控制器view被导航条、bar挡住
    vc.tableView.contentInset = UIEdgeInsetsMake(64 + _topScrollView.JG_height, 0, 49, 0) ;
    // 控制器View尺寸一开始就向下偏移了20
    vc.view.frame = [UIScreen mainScreen].bounds ;
    [cell.contentView addSubview:vc.view] ;
    
    return cell;
    
}

#pragma mark - UICollectionView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //拖动换页的时候，按钮也跟着换
    NSInteger page = scrollView.contentOffset.x/JGScreenW ;
    UIButton *btn = self.btns[page] ;
    [self setTitleSelBtn:btn] ;
}


@end
