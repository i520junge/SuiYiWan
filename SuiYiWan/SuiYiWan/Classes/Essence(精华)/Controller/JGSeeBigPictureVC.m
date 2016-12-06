//
//  JGSeeBigPictureVC.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/27.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGSeeBigPictureVC.h"
#import <UIImageView+WebCache.h>
#import "JGTopicItem.h"
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
#import "JGPhotoManager.h"

//保存到相册的相册名字
#define JGAlbumTitle @"随意玩"

@interface JGSeeBigPictureVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak) UIImageView *imageView;

@end

@implementation JGSeeBigPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置_scrollView的代理
    _scrollView.delegate = self ;
    
    //展示大图
    UIImageView *imageView = [[UIImageView alloc] init] ;
    //取图片，如果缓存中有，从缓存中取，没有从磁盘中取，还是没有就下载
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.image2] placeholderImage:nil options:SDWebImageProgressiveDownload] ;
    [_scrollView addSubview:imageView] ;
    _imageView = imageView ;
    
    CGFloat imageH = JGScreenW/_item.width *_item.height ;
    imageView.frame = CGRectMake(0, 0, JGScreenW, imageH) ;
    
    //大图，置顶显示，可捏合
    if (self.item.isBigPicture) {
        _scrollView.contentSize = CGSizeMake(0, imageH) ;
//        _scrollView.maximumZoomScale = self.item.width/JGScreenW ;    //不能放在这儿，因为有些虽然没有标记为大图，但是是经过宽高比压缩为不超过屏幕高度的图片，这些压缩了的，也是可以放大的
    }
    //小图，中心显示
    else{
        imageView.center = CGPointMake(JGScreenW*0.5, JGScreenH*0.5) ;
    }
    
    //将压缩过的图片可放大到原图效果
    if (self.item.width/JGScreenW >= 1) {
        _scrollView.maximumZoomScale = self.item.width/JGScreenW ;
    }
    
}

/*
 // 保存图片到自己的自定义相册 Photos 导入<Photos/Photos.h>
 
 PHPhotoLibrary：相簿（所有相册集合）
 PHAsset:图片
 PHAssetCollection:相册，所有相片集合
 PHAssetChangeRequest:创建，修改，删除图片
 PHAssetCollectionChangeRequest:创建，修改，删除相册
 
 
 */
//点击保存图片按钮
#pragma mark - 保存图片
- (IBAction)saveClick:(UIButton *)sender {
    
//    显示提示框，询问用户是否允许当前App访问相册
//    1、获取用户授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus] ;
    
//    2、判断，不确定（授权就保存）、授权（直接保存）、拒绝（提示用户去开授权）。
    if (status == PHAuthorizationStatusNotDetermined) {     //不确定
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {      //不确定则弹框问用户是否允许
            if (status == PHAuthorizationStatusAuthorized) {    //如果用户授权了就保存照片
                [JGPhotoManager savePhotos:_imageView.image albumTitle:JGAlbumTitle completionHandler:^(BOOL success, NSError * _Nullable error) {
                    [self showHUDWithStatues:success] ;     //提示用户是否保存成功
                }] ;
            }
        }] ;

    }else if (status == PHAuthorizationStatusAuthorized){       //授权了，就直接保存图片
        
        [JGPhotoManager savePhotos:_imageView.image albumTitle:JGAlbumTitle completionHandler:^(BOOL success, NSError * _Nullable error) {
            [self showHUDWithStatues:success] ;     //提示用户是否保存成功
        }] ;
        
    }else{      //用户拒绝了，提示用户去授权
        [SVProgressHUD showInfoWithStatus:@"请允许访问相册……"] ;
    }
    
}

//提示是否保存成功
-(void)showHUDWithStatues:(BOOL)success{
    if (success) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"] ;
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存失败"] ;
        
    }
    //0.25秒后马上消失指示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss] ;
    });
}





//点击返回按钮
- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

#pragma mark - scrollView的代理方法
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView ;
}

@end
