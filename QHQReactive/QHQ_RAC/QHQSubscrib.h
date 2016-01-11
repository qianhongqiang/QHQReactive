//
//  QHQSubscrib.h
//  PageText
//
//  Created by qianhongqiang on 15/12/26.
//  Copyright © 2015年 qianhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QHQSubscrib <NSObject>

-(void)sendNext:(id)next;

-(void)sendError:(NSError *)error;

-(void)sendCompleted;

@end
