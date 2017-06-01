//
//  TTMessageModel.m
//  TTChatDemo
//
//  Created by zhang liangwang on 17/2/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTMessageModel.h"

@implementation TTMessageModel

+ (instancetype)messageWithDict:(NSDictionary *)dict {
    
    TTMessageModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
}

@end
