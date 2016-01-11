//
//  QHQSubscriber.h
//  PageText
//
//  Created by qianhongqiang on 15/12/17.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHQSubscrib.h"

@interface QHQSubscriber : NSObject<QHQSubscrib>

+(instancetype)subscriberWithNextBlock:(void (^)(id x))nextBlock;

+(instancetype)subscriberWithNextBlock:(void (^)(id x))nextBlock completionBlock:(void (^)(void))completionBlock errorBlock:(void (^)(id x))errorBlock;

-(void)sendNext:(id)next;

@end
