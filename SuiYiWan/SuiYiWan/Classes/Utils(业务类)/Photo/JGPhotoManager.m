//
//  JGPhotoManager.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/29.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGPhotoManager.h"
#import <Photos/Photos.h>


@implementation JGPhotoManager

+(void)savePhotos:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError * _Nullable error))completionHandler {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //判断之前有没有相册
        PHAssetCollection *assetCollection = [self fetchAssetColletion:albumTitle] ;

        PHAssetCollectionChangeRequest *assetCollectionChangeRequest ;
        
        if (assetCollection) {      //之前有这个相册，直接拿这个相册存
            
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection] ;
            
        }else{                              //没有就创建一个新相册
            
        // 1.创建自定义相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle] ;
        }
        // 2.保存图片到系统相册
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image] ;
        
        // 3.把创建好图片添加到自己相册
        PHObjectPlaceholder *objectPlaceholder = [assetChangeRequest placeholderForCreatedAsset] ;      //把图片放在占位对象中
        [assetCollectionChangeRequest addAssets:@[objectPlaceholder]] ;     //NSFastEnumeration是数组
        
        
    } completionHandler:completionHandler       //执行外面传进来的block模块
//        completionHandler:^(BOOL success, NSError * _Nullable error) {
//        if (completionHandler) {
//            completionHandler(success,error) ;
//        }
//      }
     
   ] ;
}


#pragma mark - 获取之前相册
//防止创建多次相册方法：
//1、定义属性记录已经创建一次。缺点：当退出程序再进来时，这个属性值为0，又要重新赋值，会再次创建
//2、将记录创建文件夹的属性保存至沙盒。缺点：当用户卸载时，沙盒记录消失，相册没消失，再次安装软件时，会再次创建文件夹。
//3、遍历所有相册名字，判断是否有同名的

//用于防止创建多次一样的相册
+(PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle{
    //获取所有的相册名
    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil] ;
    //遍历所有相册名，看是否相同
    for (PHAssetCollection *assetCollection in fetchResult) {
        
        if ([assetCollection.localizedTitle isEqualToString:albumTitle ]) {   //有同名的相册，将相册传出去
            return assetCollection ;
        }
    }
    
    return nil ;
}
@end
