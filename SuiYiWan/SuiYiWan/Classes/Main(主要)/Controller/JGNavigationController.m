//
//  JGNavigationController.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGNavigationController.h"
#import "JGNavigationBar.h"
#import "JGBackView.h"

@interface JGNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JGNavigationController
+(void)load{
    //获取全局控件
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil] ;
    bar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20]} ;
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault] ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条为自定义导航条
    JGNavigationBar *navigationBar = [[JGNavigationBar alloc] init] ;
//    self.navigationBar = navigationBar ;
    //由于导航条是只读属性，只能用KVC设置
    [self setValue:navigationBar forKey:@"navigationBar"] ;
    
    //设置滑动返回手势
    [self setPanToPanBack] ;
    
  
    
}

#pragma mark - 添加滑动返回手势
/* 设置全屏滑动返回功能 */
/*
 ①、需求：自定义返回按钮，边缘 拥有滑动返回功能
 不重写返回按钮时，系统默认有边缘滑动返回功能
 ---->猜测系统有手势
 ---->到UINavigationController系统提供的类中找gesture，找到ios7.0self.interactivePopGestureRecognizer这个属性控制了滑动返回
 ---->验证，给这个手势的代理设置为self，然后代理方法中- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch返回NO看看系统提供的滑动返回功能是否还有，验证发现确实没有了，说明系统就是通过interactivePopGestureRecognizer这个属性控制的
 ---->清空原来手势代理对象，设置本控制器为手势的代理对象，并且从第二个控制器开始，即重写返回按钮，也有滑动返回功能self.interactivePopGestureRecognizer.delegate = self ;
 
 ②、需求：自定义返回按钮，全屏 拥有滑动返回功能
 ---->不要系统原来边缘滑动返回的手势，重新添加手势，把这个滑动返回的手势添加到整个导航控制器的View上面，但是手势滑动触发的方法还是调用系统的（action=handleNavigationTransition:），自己不重写
 ---->要想调用系统原来触发的方法，必须把手势的代理对象设置为拥有这个方法的类创建得对象
 target=<_UINavigationInteractiveTransition 0x7ff9d9573f20>)>>
 self.interactivePopGestureRecognizer.delegate--<_UINavigationInteractiveTransition: 0x7fe569d30140>
 */

-(void)setPanToPanBack{
    //将系统原来的手势禁用
    self.interactivePopGestureRecognizer.enabled = NO ;
    
    //找到系统拥有handleNavigationTransition:这个方法的类对象作为调用那个方法的监听者
    id target = self.interactivePopGestureRecognizer.delegate ;
    
    //添加手势到view上面
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)] ;
    pan.delegate = self ;
    [self.view addGestureRecognizer:pan] ;

}

//手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}




#pragma mark - 拦截push，统一设置返回按钮
//拦截push，统一设置返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //从第二个栈顶控制器开始要有返回按钮
    if (self.childViewControllers.count > 0) {
        //设置返回按钮
        [self setBackClick:viewController] ;
    }
    
    [super pushViewController:viewController animated:animated] ;
}

//设置返回按钮
-(void)setBackClick:(UIViewController *)viewController{
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[JGBackView backViewWithBtnNormalImageName:@"navigationButtonReturn" highImageName:@"navigationButtonReturnClick" normalTitle:@"返回" highTitle:@"返回" target:self action:@selector(backClick)]] ;
    
    //隐藏tabBar，一定要在push之前设置
    viewController.hidesBottomBarWhenPushed = YES ;
}

-(void)backClick{
    [self popViewControllerAnimated:YES] ;
}

@end
