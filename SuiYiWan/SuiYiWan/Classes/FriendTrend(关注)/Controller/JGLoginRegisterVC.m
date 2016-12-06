//
//  JGLoginRegisterVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/17.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGLoginRegisterVC.h"
#import "JGLoginView.h"

@interface JGLoginRegisterVC ()
@property (weak, nonatomic) IBOutlet UIView *loginRegistView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;


@end

@implementation JGLoginRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载登录和注册界面
    [self loadLoginRegisterView] ;
    
}

- (IBAction)closeClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
- (IBAction)loginRegister:(UIButton *)loginRegisterBtn {
    loginRegisterBtn.selected = !loginRegisterBtn.selected ;
    
    //移动loginRegistView
    _leftMargin.constant = (_leftMargin.constant == 0)?-JGScreenW:0 ;
      
    //动画刷新界面
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded] ;
    }] ;

}

#pragma mark - 加载登录、注册界面
-(void)loadLoginRegisterView{
    //加载登录界面
    JGLoginView *loginView = [JGLoginView loginView] ;
    //这里参考view会有问题，参考UIScreen不会有问题
//    loginView.frame = CGRectMake(0, 0, self.loginRegistView.JG_width *0.5,self.loginRegistView.JG_height );
    [self.loginRegistView addSubview:loginView] ;
    
    //加载注册界面
    JGLoginView *registerView = [JGLoginView registerView] ;
    [self.loginRegistView addSubview:registerView] ;
}

// 计算好所有子控件的位置完成的时候调用
// 执行完约束
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews] ;
    //设置登录注册按钮的frame
    _loginRegistView.subviews[0].frame = CGRectMake(0, 0, _loginRegistView.JG_width *0.5,_loginRegistView.JG_height );
    _loginRegistView.subviews[1].frame = CGRectMake(_loginRegistView.JG_width*0.5, 0, _loginRegistView.JG_width *0.5, _loginRegistView.JG_height) ;
}

@end
