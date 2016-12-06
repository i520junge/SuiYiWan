//
//  UIImage+Randar.h
//  SuiYiWan
//
//  Created by 刘军 on 16/10/16.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Randar)

/**
 让图片不被渲染

 @param imageName 图片名称

 @return 不被渲染的图片
 */
+(UIImage *)imageNamedWithOriginal:(NSString *)imageName ;


/**
 获得新的圆形图片

 @param image 传入需要裁剪成圆形的图片

 @return 返回裁剪好的圆形图片
 */
+(UIImage *)imageToRoundImageWithImage:(UIImage *)image ;

/**
 传入图片，获得有边框、边框颜色的圆形图片

 @param borderW 边框宽度
 @param color   变宽颜色
 @param image   传入图片

 @return 获得有边框、边框颜色的圆形新图片
 */
+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image;

@end
