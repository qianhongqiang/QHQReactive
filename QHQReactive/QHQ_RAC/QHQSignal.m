//
//  QHQSignal.m
//  PageText
//
//  Created by qianhongqiang on 15/12/17.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "QHQSignal.h"
#import "QHQSubscriber.h"
#import "QHQMulticastConnection.h"
#import "QHQSubject.h"
#import "QHQReplaySubject.h"

@interface QHQSignal ()

@property (nonatomic, copy) QHQDispose *(^didSubscriber)(id subscriber);
@property (nonatomic, strong) QHQSubscriber *scriber;

@end

@implementation QHQSignal

+(QHQSignal *)createSignal:(QHQDispose *(^)(id subscriber))didSubscriber {
    QHQSignal *signal = [[self alloc] init];
    signal.didSubscriber = didSubscriber;
    return signal;
}

-(void)subscribeNext:(void (^)(id x))nextBlock {
    [self subscribeNext:nextBlock error:nil completed:nil];
}

-(void)subscribeNext:(void (^)(id x))nextBlock error:(void(^)(NSError *error))errorBlock completed:(void(^)(void))completedBlock {
    QHQSubscriber *scriber = [QHQSubscriber subscriberWithNextBlock:nextBlock completionBlock:completedBlock errorBlock:errorBlock];
    self.scriber = scriber;
    [self subscribe:scriber];
}

-(void)subscribe:(id<QHQSubscrib>)sub {
    self.didSubscriber(sub);
}

-(QHQSignal *)concat:(QHQSignal *)concatSignal {
    return [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [self subscribeNext:^(id next) {
            [subscriber sendNext:next];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        } completed:^{
            [concatSignal subscribe:subscriber];
        }];
        return nil;
    }];
}

-(QHQSignal *)zip:(QHQSignal *)signal {
    
    return [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        NSMutableArray *selfArray = [NSMutableArray array];
        NSMutableArray *zipArray = [NSMutableArray array];
        
        void (^sendZip)(void) = ^{
            if (selfArray.count == 0) return;
            if (zipArray.count == 0) return;
            
            NSArray *send = [NSArray arrayWithObjects:selfArray.firstObject, zipArray.firstObject,nil];;
            
            [selfArray removeObjectAtIndex:0];
            [zipArray removeObjectAtIndex:0];
            
            [subscriber sendNext:send];
            
        };
        
        [self subscribeNext:^(id x) {
            [selfArray addObject:x];
            sendZip();
        }];
        
        [signal subscribeNext:^(id x) {
            [zipArray addObject:x];
            sendZip();
        }];
        return  nil;
    }];
    
}

-(QHQSignal *)replay {
    QHQMulticastConnection *conn = [[QHQMulticastConnection alloc] initWithSourceSignal:self outSignalSubject:[[QHQSubject alloc] init]];
    [conn connectSignal];
    return conn.connSignal;
}

-(QHQSignal *)replayLazily {
    QHQMulticastConnection *conn = [[QHQMulticastConnection alloc] initWithSourceSignal:self outSignalSubject:[QHQReplaySubject replaySubjectWithCapacity:1]];
    [conn connectSignal];
    return conn.connSignal;
}

@end
