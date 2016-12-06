//
//  JGFileManager.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/23.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGFileManager : NSObject

/**
 获取文件夹的文件大小

 @param directoryPath 文件夹路径
 */
//+(NSInteger)getDirectorySize:(NSString *)directoryPath ;
+ (void)getDirectorySize:(NSString *)directoryPath completion:(void(^)(int))completion ;

/**
 获取清除缓存的字符“清除缓存（ MB）”

 @param directoryPath 文件夹路径

 @return 清除缓存的文件字符串
 */
//+ (NSString *)directorySizeString:(NSString *)directoryPath ;
+(void)directorySizeString:(NSString *)directoryPath strCompletion:(void(^)(NSString*))strCompletion ;

/**
 移除磁盘缓存

 @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath ;
@end
