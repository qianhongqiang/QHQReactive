//
//  QHQDispose.m
//  PageText
//
//  Created by qianhongqiang on 16/1/7.
//  Copyright © 2016年 qianhongqiang. All rights reserved.
//

#import "QHQDispose.h"

@interface QHQDispose()

@property (nonatomic, copy) void(^disposeBlock)(void);

@end

@implementation QHQDispose

- (id)initWithBlock:(void (^)(void))block {
    self = [super init];
    if (self == nil) return nil;
    _disposeBlock = block;
    return self;
}

+(instancetype)disposeWithBlock:(void (^)(void))block {
    return [[self alloc] initWithBlock:block];
}

-(void)dispose {
    self.disposeBlock();
}

@end
