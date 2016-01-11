//
//  UIControl+QHQSignal.h
//  PageText
//
//  Created by qianhongqiang on 15/12/30.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHQSignal.h"

@interface UIControl (QHQSignal)

-(QHQSignal *)qhq_signalForControlEvents:(UIControlEvents)event;

@end
