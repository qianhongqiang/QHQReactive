//
//  QHQDispose.h
//  PageText
//
//  Created by qianhongqiang on 16/1/7.
//  Copyright © 2016年 qianhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHQDispose : NSObject

+(instancetype)disposeWithBlock:(void(^)(void))block;

-(void)dispose;

@end
