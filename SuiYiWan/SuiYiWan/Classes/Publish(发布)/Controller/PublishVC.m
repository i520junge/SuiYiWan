//
//  PublishVC.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/15.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "PublishVC.h"
#import "JGFastLoginBtn.h"

@interface PublishVC ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,strong)UIImageView *sloganView ;
@end

@implementation PublishVC
-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array] ;
    }
    return _btns ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加九宫格按钮
    [self addBtn] ;
    
    //添加标语
    [self setupSloganView] ;
}

//即将显示的时候，把按钮的形变恢复
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    //遍历所有按钮，将按钮动画显示出来
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i] ;
        //每一个动画添加一个延时时间.
        [UIView animateWithDuration:0.5 delay: i * 0.05 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            //清空形变.
            btn.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
            self.sloganView.transform = CGAffineTransformIdentity ;
            }] ;
        }];
    }
}

#pragma mark - 添加九宫格按钮
-(void)addBtn{
    // 图片、标题
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //展示的列、行
    NSInteger count = images.count ;
    NSInteger cols = 3 ;
    NSInteger row = count/cols + (count%cols > 0) ;
    
    //每个按钮宽、高、开始的Y值
    CGFloat btnW = JGScreenW/cols ;
    CGFloat btnH = btnW * 0.85 ;
    CGFloat startY = (JGScreenH - row * btnH) * 0.5 ;
    
    //添加按钮
    for (int i = 0; i < count; i++) {
        JGFastLoginBtn *btn = [JGFastLoginBtn buttonWithNormalImageName:images[i] title:titles[i]] ;
        
        //设置frame
        CGFloat btnX = (i%cols)*btnW ;
        CGFloat btnY = startY + (i/cols)*btnH ;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH) ;
        [self.view addSubview:btn] ;
        
        //加载按钮时先将全部按钮移至屏幕外面
        btn.transform = CGAffineTransformMakeTranslation(0, JGScreenH) ;
        [self.btns addObject:btn] ;
        //添加监听
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside] ;
    }
}
//点击按钮时
-(void)btnClick:(JGFastLoginBtn *)btn{
    
}

#pragma mark - 点击取消按钮
- (IBAction)cancelBtnClick:(UIButton *)sender {
   [self exitAnimation:^{
       //动画完成时控制器消失
       [self dismissViewControllerAnimated:YES completion:nil] ;
   }] ;
}
//点击屏幕
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelBtnClick:nil] ;
}

#pragma mark - 动画退出
-(void)exitAnimation:(void(^)())task{
    //遍历所有按钮，将按钮动画显示出来
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i] ;
        //每一个动画添加一个延时时间.
        [UIView animateWithDuration:0.5 delay: i * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            //将按钮形变至屏幕外面.
            btn.transform = CGAffineTransformMakeTranslation(0, JGScreenH) ;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.sloganView.transform = CGAffineTransformIdentity ;
            } completion:^(BOOL finished) {
                task() ;
            }] ;
            
        }];
    }
}

#pragma mark - 添加标语
-(void)setupSloganView{
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]] ;
    sloganView.JG_y = JGScreenH * 0.2 ;
    sloganView.JG_centerX = JGScreenW * 0.5 ;
    [self.view addSubview:sloganView] ;
    self.sloganView = sloganView ;
    //先将标语形变
    sloganView.transform = CGAffineTransformMakeTranslation(0, JGScreenH) ;
    
}
@end
