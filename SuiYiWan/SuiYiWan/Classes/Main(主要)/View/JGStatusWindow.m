//
//  JGStatusWindow.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/31.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGStatusWindow.h"

static JGStatusWindow *_statusWindow ;      //定义一个属性引用着下面创建得Window，防止一创建就销毁

@implementation JGStatusWindow
+(void)show{
//    1、创建自己的状态栏窗口
    JGStatusWindow *statusWindow = [[JGStatusWindow alloc] initWithFrame:CGRectMake(0, 0, JGScreenW, 20)] ;
    
//    2、设置窗口的根控制器，必须添加，不然程序会蹦
    statusWindow.rootViewController = [[UIViewController alloc] init] ;
    
//    3、显示出窗口
    statusWindow.hidden = NO ;
    _statusWindow = statusWindow ;
    
    //当添加多个窗口时，系统的状态栏会自动消失，所以手动让它显示，手动显示的话必须在info.plist里面把View controller-based status bar appearance改为NO，意思就是取消控制器对状态栏的管理权限，把权利交给UIApplication
    [UIApplication sharedApplication].statusBarHidden = NO ;
    
    //设置自己创建的statusWindow优先级高于状态栏优先级，有3个优先级，正常<状态栏<Alert
    statusWindow.windowLevel = UIWindowLevelAlert ;
}


//点击状态栏，让tableView回到顶部
//方法1：用通知，点击了就马上通知让tableView控制器去偏移
//方法2：用递归，遍历显示在主窗口的所有子控件，找到当前需要置顶的tableView，让他偏移

//递归和死循环的区别是：递归有结束语句
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    1、拿到当前主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow ;
    
//    2、遍历当前主窗口的子控件，找到tableView
    UITableView *tableView  = [self fetchTableView:keyWindow] ;
    
//    3、让tableView偏移到顶部
//    tableView.contentOffset = CGPointMake(0, -99) ;
    [tableView setContentOffset:CGPointMake(0, -tableView.contentInset.top) animated:YES] ;
}

#pragma mark - 获取控件的所有子控件
-(UITableView *)fetchTableView:(UIView *)view{
    //遍历view的所有子控件
    for (UIView *childView in view.subviews) {
        //如果是UITableView就传出去
        if ([childView isKindOfClass:[UITableView class]]) {
            return (UITableView *)childView ;
        }
        
        //如果不是就继续遍历，直到没有子控件，这个递归就结束
        UITableView *tableView = [self fetchTableView:childView] ;
        if (tableView) {
            return tableView ;
        }
    }
    return nil ;
}

@end
