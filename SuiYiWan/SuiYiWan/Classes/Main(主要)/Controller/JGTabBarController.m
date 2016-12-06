//
//  JGTabBarController.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/15.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGTabBarController.h"
#import "EssenceVC.h"
#import "FriendTrendVC.h"
#import "PublishVC.h"
#import "NewVC.h"
#import "MeTableVC.h"
#import "UIImage+Randar.h"
#import "JGNavigationController.h"

@interface JGTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)UIButton *publishBtn;

/**
 记录点击了tabbar后显示的控制器
 */
@property(nonatomic,weak)UIViewController *selectedVC;
@end

@implementation JGTabBarController



//当加载本类时会调用一次这个方法
+(void)load{
    //获取当前类的全局控件
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil] ;
    NSMutableDictionary *attriDict = [NSMutableDictionary dictionary] ;
    attriDict[NSFontAttributeName] = [UIFont systemFontOfSize:14] ;
//    attriDict[NSForegroundColorAttributeName] = [UIColor blackColor] ;
    [tabBarItem setTitleTextAttributes:attriDict forState:UIControlStateNormal] ;//文字要在正常状态下设置
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabBar的背景图片
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"] ;
    //添加所有子控制器
    [self addAllChildViewController] ;
    //设置渲染颜色
    self.tabBar.tintColor = [UIColor blackColor] ;
    //设置中间加号按钮
    self.publishBtn.center = CGPointMake(self.tabBar.JG_width*0.5, self.tabBar.JG_height*0.5) ;
    
    //设置自己为自己的代理,一般情况不要这样做
    self.delegate = self ;
    
    //一开始记录系统默认被选中的控制器
    _selectedVC = self.childViewControllers[0] ;
}

#pragma mark - 代理方法监听重复点击
//每次点击tabBar按钮的时候就会来到这个方法
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //用一个属性去记录当前点击的控制器
    if (_selectedVC == viewController) {    //如果选中的控制器跟上一次选中的一样，则通知控制器去刷新数据，因为选中的控制器与要刷新的控制器隔很多级，所以用通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatClickTab" object:nil] ;
        
    }
    _selectedVC = viewController ;
}



#pragma mark - 添加所有子控制器
-(void)addAllChildViewController{
    //精华
    EssenceVC *essenceVC = [[EssenceVC alloc] init] ;
    [self setOneChildViewController:essenceVC title:@"精华" imageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon"] ;
    
    //新帖
    NewVC *newVC = [[NewVC alloc] init] ;
    [self setOneChildViewController:newVC title:@"新帖" imageName:@"tabBar_new_icon" selectImageName:@"tabBar_new_click_icon"] ;
    
    //发布
    UIViewController *publishVC = [[UIViewController alloc] init] ;
    publishVC.tabBarItem.enabled = NO ;
    [self addChildViewController:publishVC] ;
    
    //关注
    FriendTrendVC *friendTrendVC = [[FriendTrendVC alloc] init] ;
    [self setOneChildViewController:friendTrendVC title:@"关注" imageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon"] ;
    
    //我
    UIStoryboard *storyB = [UIStoryboard storyboardWithName:@"MeTableVC" bundle:nil] ;
    MeTableVC *meVC = [storyB instantiateInitialViewController] ;
    [self setOneChildViewController:meVC title:@"我" imageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon"] ;
    
}


/* 设置控制器的TabBar */
-(void)setOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
//    vc.tabBarItem.title = title ;     //如果下面不设置图片则不会显示文字
    if (imageName.length) {
        vc.tabBarItem.image = [UIImage imageNamed:imageName] ;
        vc.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:selectImageName] ;
        
    }
    JGNavigationController *navC = [[JGNavigationController alloc] initWithRootViewController:vc] ;
    navC.tabBarItem.title = title ;
    
    [self addChildViewController:navC] ;
}

#pragma mark - 中间按钮
//懒加载中间按钮
-(UIButton *)publishBtn{
    if (!_publishBtn) {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _publishBtn = publishBtn ;
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal] ;
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted] ;
        [publishBtn sizeToFit] ;
        //监听按钮
        [publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside] ;
        [self.tabBar addSubview:publishBtn] ;
    }
    return _publishBtn ;
}
-(void)publishBtnClick{
    PublishVC *publishVC = [[PublishVC alloc] init] ;
    [self presentViewController:publishVC animated:YES completion:nil] ;
}

@end
