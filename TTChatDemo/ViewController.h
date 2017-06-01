//
//  ViewController.h
//  TTChatDemo
//
//  Created by zhang liangwang on 17/2/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeviceInfoBlock)(NSString *text,NSError *error);

@interface ViewController : UIViewController

@property (nonatomic,copy) DeviceInfoBlock deviceInfoBlock;

@property (nonatomic,copy) void(^SendPersonInfoBlock)(NSString *text,NSError *error);


@end

