//
//  QHQSubscriptingAssignmentTrampoline.h
//  QHQReactive
//
//  Created by qianhongqiang on 16/1/15.
//  Copyright © 2016年 qianhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHQSignal.h"

#define QHQ(TARGET, KEYPATH) \
[[QHQSubscriptingAssignmentTrampoline alloc] initWithTarget:(TARGET)][KEYPATH]

@interface QHQSubscriptingAssignmentTrampoline : NSObject

- (id)initWithTarget:(id)target;

- (void)setObject:(QHQSignal *)signal forKeyedSubscript:(NSString *)keyPath;

@end
