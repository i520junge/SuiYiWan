//
//  JGWebViewController.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/23.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGWebViewController.h"
#import <WebKit/WebKit.h>

@interface JGWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;

@property(nonatomic,weak) WKWebView *webView;

@end

@implementation JGWebViewController
//上一页
- (IBAction)leftItemClick:(id)sender {
    [_webView goBack] ;
}
//下一页
- (IBAction)rightItemClick:(UIBarButtonItem *)sender {
    [_webView goForward] ;
}
//刷新
- (IBAction)refreshClick:(UIBarButtonItem *)sender {
    [_webView reload] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加网页View
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, JGScreenW, JGScreenH) ];
    [self.containerView addSubview:webView] ;
    _webView = webView ;
    
        //加载请求,展示网页
        NSURLRequest *request = [NSURLRequest requestWithURL:_url] ;
        [webView loadRequest:request] ;

    
    //KVO监听属性的改变
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil] ;
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil] ;
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil] ;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil] ;
}

#pragma mark - 监听属性新值改变

//属性有新值就会改变
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //上一页、下一页按钮的状态
    _leftItem.enabled = _webView.canGoBack ;
    _rightItem.enabled = _webView.canGoForward ;
    
    //进度条
    _progressView.progress = _webView.estimatedProgress ;
    //进度条为1时，隐藏
    _progressView.hidden = (_progressView.progress >=1) ;
    
    //设置控制器导航条显示的文字
    self.title = _webView.title ;
}

//用了KVO一定要销毁，KVO自己无法销毁，不然会蹦，内存泄漏
-(void)dealloc{
    [_webView removeObserver:self forKeyPath:@"canGoBack"] ;
    [_webView removeObserver:self forKeyPath:@"canGoForward"] ;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"] ;
    [_webView removeObserver:self forKeyPath:@"title"] ;
}

@end
