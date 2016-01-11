//
//  QHQSignal.h
//  PageText
//
//  Created by qianhongqiang on 15/12/17.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHQSubscrib.h"
#import "QHQDispose.h"

@class QHQSubscriber;


@interface QHQSignal : NSObject<QHQSubscrib>

+(QHQSignal *)createSignal:(QHQDispose*(^)(id subscriber))didSubscriber;

-(void)subscribeNext:(void (^)(id x))nextBlock;

-(void)subscribe:(id<QHQSubscrib>)sub;

//operator
-(QHQSignal *)concat:(QHQSignal *)concatSignal;
-(QHQSignal *)zip:(QHQSignal *)signal;

-(QHQSignal *)replay;

-(QHQSignal *)replayLazily;

@end
