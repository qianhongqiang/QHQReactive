//
//  QHQSubscriptingAssignmentTrampoline.m
//  QHQReactive
//
//  Created by qianhongqiang on 16/1/15.
//  Copyright © 2016年 qianhongqiang. All rights reserved.
//

#import "QHQSubscriptingAssignmentTrampoline.h"

@interface QHQSubscriptingAssignmentTrampoline ()

@property (nonatomic, strong, readonly) id target;

@end

@implementation QHQSubscriptingAssignmentTrampoline

- (id)initWithTarget:(id)target{
    if (target == nil) return nil;
    
    self = [super init];
    if (self == nil) return nil;
    
    _target = target;
    
    return self;
}

- (void)setObject:(QHQSignal *)signal forKeyedSubscript:(NSString *)keyPath {
    [signal subscribeNext:^(id x) {
        [self.target setValue:x forKey:keyPath];
    }];
}

@end
