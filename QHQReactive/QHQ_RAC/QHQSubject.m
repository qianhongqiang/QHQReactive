//
//  QHQSubject.m
//  PageText
//
//  Created by qianhongqiang on 15/12/26.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "QHQSubject.h"
#import "QHQSubscriber.h"

@interface QHQSubject ()

@end

@implementation QHQSubject

-(instancetype)init {
    self = [super init];
    if (self) {
        _subscribers = [NSMutableArray array];
    }
    return self;
}

-(void)subscribe:(id<QHQSubscrib>)sub {
    [_subscribers addObject:sub];
}

-(void)sendNext:(id)next {
    [_subscribers enumerateObjectsUsingBlock:^(id<QHQSubscrib> QHQSubscriber, NSUInteger idx, BOOL * _Nonnull stop) {
        [QHQSubscriber sendNext:next];
    }];
}

-(void)sendCompleted {
    
}

-(void)sendError:(NSError *)error {
    
}

@end
