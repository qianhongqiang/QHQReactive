//
//  QHQSubject.h
//  PageText
//
//  Created by qianhongqiang on 15/12/26.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "QHQSignal.h"
#import "QHQSubscrib.h"

@interface QHQSubject : QHQSignal<QHQSubscrib>

@property (nonatomic, strong) NSMutableArray *subscribers;

@end
