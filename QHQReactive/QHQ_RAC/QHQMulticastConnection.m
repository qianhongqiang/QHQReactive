//
//  QHQMulticastConnection.m
//  PageText
//
//  Created by qianhongqiang on 15/12/26.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "QHQMulticastConnection.h"

@interface QHQMulticastConnection ()

@property (nonatomic, strong) QHQSignal *sourceSignal;

@property (nonatomic, assign) BOOL isConnected;

@end

@implementation QHQMulticastConnection

-(instancetype)initWithSourceSignal:(QHQSignal *)signal outSignalSubject:(QHQSubject *)subject {
    self = [super init];
    if (self) {
        _sourceSignal = signal;
        _connSignal = subject;
        _isConnected = NO;
    }
    return self;
}

-(void)connectSignal {
    [_sourceSignal subscribe:_connSignal];
}

-(QHQSignal *)autoConnectSignal {
    return [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [self.connSignal subscribe:subscriber];
        if (!self.isConnected) {
            [_sourceSignal subscribe:_connSignal];
            self.isConnected = YES;
        }
        return nil;
    }];
}

@end
