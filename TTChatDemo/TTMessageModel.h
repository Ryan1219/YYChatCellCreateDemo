//
//  TTMessageModel.h
//  TTChatDemo
//
//  Created by zhang liangwang on 17/2/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TTMessageModelType) {
    TTMessageModelType_Me = 0,
    TTMessageModelType_Other
};

@interface TTMessageModel : NSObject

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,assign) TTMessageModelType type;

@property (nonatomic,assign) BOOL hiddenTime;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
