//
//  QHQSubscriber.m
//  PageText
//
//  Created by qianhongqiang on 15/12/17.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "QHQSubscriber.h"

@interface QHQSubscriber ()

@property (nonatomic, copy) void(^nextBlock)(id x);

@property (nonatomic, copy) void(^completionBlock)(void);

@property (nonatomic, copy) void(^errorBlock)(id x);

@end

@implementation QHQSubscriber

+(instancetype)subscriberWithNextBlock:(void (^)(id x))nextBlock {
    return [self subscriberWithNextBlock:nextBlock completionBlock:nil errorBlock:nil];
}

+(instancetype)subscriberWithNextBlock:(void (^)(id x))nextBlock completionBlock:(void (^)(void))completionBlock errorBlock:(void (^)(id x))errorBlock {
    QHQSubscriber *subscriber = [[QHQSubscriber alloc] init];
    subscriber.nextBlock = nextBlock;
    subscriber.completionBlock = completionBlock;
    subscriber.errorBlock = errorBlock;
    return subscriber;
}

-(void)sendNext:(id)next {
    if (self.nextBlock) {
        self.nextBlock(next);
    }
}

-(void)sendError:(NSError *)error {
    if (self.errorBlock) {
        self.errorBlock(error);
    }
}

-(void)sendCompleted {
    if (self.completionBlock) {
        self.completionBlock();
    }
}

@end
