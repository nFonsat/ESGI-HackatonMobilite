//
//  GMHomePageController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMHomePageController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface GMHomePageController () <WCSessionDelegate>

@end

@implementation GMHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWCSession];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WCSession impl

- (void) initWCSession {
    if ([WCSession class] && [WCSession isSupported]) {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}


#pragma mark - Action User interface impl

- (IBAction)onReadyAction:(UIButton *)sender {
    NSLog(@"onReadyAction");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"isReady" : @"true"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onRoadworksDetected:(id)sender {
    NSLog(@"onRoadworksDetected");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"danger" : @"roadwork"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onTraficLightDetected:(id)sender {
    NSLog(@"onTraficLightDetected");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"danger" : @"trafic_light"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

@end
