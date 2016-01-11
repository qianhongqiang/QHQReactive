//
//  UIControl+QHQSignal.m
//  PageText
//
//  Created by qianhongqiang on 15/12/30.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "UIControl+QHQSignal.h"
#import <objc/runtime.h>

@implementation UIControl (QHQSignal)

-(QHQSignal *)qhq_signalForControlEvents:(UIControlEvents)event {
    return [QHQSignal createSignal:^QHQDispose *(id<QHQSubscrib> subscriber) {
        [self addTarget:subscriber action:@selector(sendNext:) forControlEvents:event];
        objc_setAssociatedObject(self, _cmd, subscriber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return [QHQDispose disposeWithBlock:^{
            [self removeTarget:subscriber action:@selector(sendNext:) forControlEvents:event];
            objc_removeAssociatedObjects(subscriber);
        }];
    }];
}

@end
