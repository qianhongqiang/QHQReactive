//
//  QHQMulticastConnection.h
//  PageText
//
//  Created by qianhongqiang on 15/12/26.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHQSignal.h"
#import "QHQSubject.h"
#import "QHQDispose.h"

@interface QHQMulticastConnection : NSObject

@property (nonatomic, strong) QHQSignal *connSignal;

-(instancetype)initWithSourceSignal:(QHQSignal *)signal outSignalSubject:(QHQSubject *)subject;

-(void)connectSignal;

-(QHQSignal *)autoConnectSignal;

@end
