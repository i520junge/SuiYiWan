//
//  JGFileManager.m
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/23.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "JGFileManager.h"


@implementation JGFileManager

+(void)removeDirectoryPath:(NSString *)directoryPath{
    //容错处理，如果传进来的不是文件夹，且不存在，则报错
    [self throwErrorWarningWithPath:directoryPath] ;
    
    //移除文件夹下所有文件
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:nil] ;
    //移除完，创建一个
    [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil] ;
}

+(void)directorySizeString:(NSString *)directoryPath strCompletion:(void(^)(NSString*))strCompletion{
    //容错处理，如果传进来的不是文件夹，且不存在，则报错
    [self throwErrorWarningWithPath:directoryPath] ;
    
    //计算文件夹下的文件大小
    [JGFileManager getDirectorySize:directoryPath complition:^(NSInteger fileSize) {
    
        NSString *str = @"清除缓存" ;
        //拼接字符串
        if (fileSize > 1000*1000) {
            CGFloat size = fileSize / 1000.0 / 1000.0 ;
            str = [NSString stringWithFormat:@"%@(%.1fMB)",str,size] ;
        }else if (fileSize > 1000){
            CGFloat size = fileSize / 1000.0 ;
            str = [NSString stringWithFormat:@"%@(%.1fKB)",str,size] ;
        }else if (fileSize >= 0){       //一定要加=，当再次进入时，缓存为0，可以显示“清除缓存(0B)”
            str = [NSString stringWithFormat:@"%@(%zdB)",str,fileSize] ;
        }
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""] ;
        
        //线程间通信
        dispatch_async(dispatch_get_main_queue(), ^{
            strCompletion(str) ;
        }) ;
        
    }] ;
    
}


+(void)getDirectorySize:(NSString *)directoryPath complition:(void(^)(NSInteger))complition{
    //容错处理，如果传进来的不是文件夹，且不存在，则报错
    [self throwErrorWarningWithPath:directoryPath] ;

    //计算文件大小需要遍历，是个耗时操作，所以将其放在子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
//    1.创建文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager] ;

//    2.获取文件夹路径     就是传进来的directoryPath
//    3.获取文件夹里面所有子路径数组
    NSArray *subPath = [fileManager subpathsAtPath:directoryPath] ;
    
//    4.遍历所有子路径
    NSInteger totalSize = 0 ;
    for (int i = 0; i < subPath.count; i++) {
//    5.拼接 文件全路径
        NSString *fullPath = [directoryPath stringByAppendingPathComponent:subPath[i]] ;
        
        //排除非缓存文件，不计算隐藏文件和文件夹大小
        if ([fullPath containsString:@".DS"]) continue;     //排除隐藏文件
        if ([fullPath containsString:@"/Cache."]) continue ;
        BOOL isDirectory = NO ;
        BOOL isExists = [fileManager fileExistsAtPath:fullPath isDirectory:&isDirectory] ;
        if (!isExists || isDirectory) continue ;
        
//    6.attributesOfItemAtPath: 指定文件全路径，就能获取文件属性
        NSDictionary *attriDict =  [fileManager attributesOfItemAtPath:fullPath error:nil] ;
        
//     7、获取文件尺寸，并累加
        totalSize +=[attriDict fileSize] ;
    }
        
        //外界刷新UI，进行线程间通信
        dispatch_async(dispatch_get_main_queue(), ^{
            complition(totalSize) ;
        }) ;
        
        }) ;

}

/*
 获取文件夹尺寸 => 遍历文件夹所有文件，把文件尺寸累加
 
 1.创建文件管理者
 2.获取文件夹路径
 3.获取文件夹里面所有子路径
 4.遍历所有子路径
 5.拼接 文件全路径
 6.attributesOfItemAtPath: 指定文件全路径，就能获取文件属性
 7.获取文件尺寸
 8.累加
 */


//容错处理，如果传进来的不是文件夹，且不存在，则报错，抛异常
+(void)throwErrorWarningWithPath:(NSString *)path{
    BOOL isDirectory = NO ;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory] ;
    if (!isExists || !isDirectory){
        NSException *exc = [NSException exceptionWithName:@"FileError" reason:@"传入的路径不存在，或者不是文件夹" userInfo:nil] ;
        @throw exc ;
//        [exc raise] ;     //这个也可以
    }
}

@end
