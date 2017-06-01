//
//  TTChatTableViewCell.h
//  TTChatDemo
//
//  Created by zhang liangwang on 17/2/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTMessageModel.h"

@interface TTChatTableViewCell : UITableViewCell

@property (nonatomic,strong) TTMessageModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
