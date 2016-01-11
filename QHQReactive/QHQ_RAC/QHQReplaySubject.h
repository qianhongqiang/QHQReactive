//
//  QHQReplaySubject.h
//  PageText
//
//  Created by qianhongqiang on 15/12/29.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import "QHQSubject.h"

@interface QHQReplaySubject : QHQSubject

+(instancetype)replaySubjectWithCapacity:(NSUInteger)capacity;

@end
