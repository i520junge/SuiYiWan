//
//  AFHTTPSessionManager+Manager.m
//  SuiYiWan
//
//  Created by 刘军 on 16/10/18.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import "AFHTTPSessionManager+Manager.h"

@implementation AFHTTPSessionManager (Manager)
+(instancetype)jg_manager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer] ;
    
    //设置manager在遇到text/html时也用JSON解析
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    manager.responseSerializer = response ;
    return manager ;
}
@end
