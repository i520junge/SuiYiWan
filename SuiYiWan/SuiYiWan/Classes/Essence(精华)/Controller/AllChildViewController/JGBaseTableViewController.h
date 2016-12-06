//
//  JGBaseTableViewController.h
//  SuiYiWan
//
//  Created by 刘军 on 2016/10/26.
//  Copyright © 2016年 JunGe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGTopicItem.h"

@interface JGBaseTableViewController : UITableViewController
@property(nonatomic,assign)JGTopicItemType type;

//提供方法，让重复点击按钮刷新数据
-(void)reloadData;
@end
