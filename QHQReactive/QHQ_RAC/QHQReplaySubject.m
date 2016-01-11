//
//  QHQReplaySubject.m
//  PageText
//
//  Created by qianhongqiang on 15/12/29.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "QHQReplaySubject.h"

@interface QHQReplaySubject ()

@property (nonatomic, assign) NSUInteger capacity;
@property (nonatomic, strong) NSMutableArray *values;

@end

@implementation QHQReplaySubject

+(instancetype)replaySubjectWithCapacity:(NSUInteger)capacity {
    return [[QHQReplaySubject alloc] initWithCapacity:capacity];
}

- (instancetype)init {
    return [self initWithCapacity:10000];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (self == nil) return nil;
    _capacity = capacity;
    _values = [NSMutableArray array];
    return self;
}

-(void)subscribe:(id<QHQSubscrib>)sub {
    for (id value in _values) {
        [sub sendNext:value];
    }
    [self.subscribers addObject:sub];
}

-(void)sendNext:(id)next {
    [_values addObject:next];
    [super sendNext:next];
    
    if (_values.count >_capacity) {
        [_values removeObjectAtIndex:0];
    }
}

@end
