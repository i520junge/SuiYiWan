//
//  JGTagCell.h
//  SuiYiWan
//
//  Created by 刘军 on 16/10/19.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGSubTagItem ;

@interface JGTagCell : UITableViewCell
@property(nonatomic,strong)JGSubTagItem *tagItem;

/**
提供类方法方便加载XIB的cell
 */
+(instancetype)tagCell ;
@end
