//
//  ViewController.m
//  QHQReactive
//
//  Created by qianhongqiang on 16/1/11.
//  Copyright © 2016年 qianhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "QHQSignal.h"
#import "QHQSubscriber.h"
#import "QHQSubject.h"
#import "UIControl+QHQSignal.h"
#import "QHQSubscriptingAssignmentTrampoline.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self demoFiveUIControl];
    [self demoSix];
    
}

-(void)demoOne {
    QHQSignal *demoSignal = [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [subscriber sendNext:@"1"];
        return nil;
    }];
    
    [demoSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

-(void)demoTwoConcat {
    QHQSignal *demoOriginSignal = [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [subscriber sendNext:@"demoOriginSignal - send"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    QHQSignal *demoConcatSignal = [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [subscriber sendNext:@"demoConcatSignal - send"];
        return nil;
    }];
    
    [[demoOriginSignal concat:demoConcatSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

-(void)demoTwoZip {
    QHQSignal *demoOriginSignal = [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [subscriber sendNext:@"demoOriginSignal - send- zip1"];
        [subscriber sendNext:@"demoOriginSignal - send- zip2"];
        return nil;
    }];
    
    QHQSignal *demoConcatSignal = [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [subscriber sendNext:@"demoConcatSignal - send - zip1"];
        [subscriber sendNext:@"demoConcatSignal - send - zip2"];
        return nil;
    }];
    
    [[demoOriginSignal zip:demoConcatSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

-(void)demoThreeHotSignal {
    QHQSubject *demoPush = [[QHQSubject alloc] init];
    
    [demoPush subscribeNext:^(id x) {
        NSLog(@"%@---sub1",x);
    }];
    
    [demoPush subscribeNext:^(id x) {
        NSLog(@"%@---sub2",x);
    }];
    
    [demoPush sendNext:@"demopush"];
}

-(void)demoThreeReplay {
    QHQSignal *replaySignal = [[QHQSignal createSignal:^QHQDispose *(id subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"----send");
            [subscriber sendNext:@"888"];
        });
        return nil;
    }] replay];
    
    [replaySignal subscribeNext:^(id x) {
        NSLog(@"sub1 ---- %@",x);
    }];
    
    [replaySignal subscribeNext:^(id x) {
        NSLog(@"sub2 ---- %@",x);
    }];
}

-(void)demoFourReplayLazily {
    QHQSignal *replaySignal = [[QHQSignal createSignal:^QHQDispose *(id subscriber) {
        NSLog(@"replaySignal----send");
        [subscriber sendNext:@"replaySignal---send"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"Delay-----replaySignal----send");
            [subscriber sendNext:@"Delay-----replaySignal---send"];
        });
        return nil;
    }] replayLazily];
    
    [replaySignal subscribeNext:^(id x) {
        NSLog(@"sub1 ---- %@",x);
    }];
    
    [replaySignal subscribeNext:^(id x) {
        NSLog(@"sub2 ---- %@",x);
    }];
}

-(void)demoFiveUIControl {
    UIButton *demoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
    [self.view addSubview:demoButton];
    demoButton.backgroundColor = [UIColor grayColor];
    [demoButton setTitle:@"demo" forState:UIControlStateNormal];
    [demoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[demoButton qhq_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
        NSLog(@"%@---被点击了",x);
    }];
}

-(void)demoSix {
    QHQ(self.view,@"backgroundColor") = [QHQSignal createSignal:^QHQDispose *(id subscriber) {
        [subscriber sendNext:[UIColor yellowColor]];
        return nil;
    }];
}

@end
