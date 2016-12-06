//
//  JGBaseTopicView.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/25.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGTopicItem.h"

@interface JGBaseTopicView : UIView

@property(nonatomic,strong)JGTopicItem *item;

/**
 j加载这个类的XIB

 @return 返回一个加载了XIB的View
 */
+(instancetype)viewForXib ;

@end
