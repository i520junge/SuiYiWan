//
//  JGPhotoManager.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/29.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGPhotoManager : NSObject
// 使用前要主动获取用户相册的授权

/**
 将图片保存至自定义相册

 @param image             需要保存的图片
 @param albumTitle        保存的相册名字
 @param completionHandler 保存成功或失败后的提示代码块
 */
+(void)savePhotos:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError *error))completionHandler ;


@end
