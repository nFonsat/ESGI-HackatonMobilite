//
//  GMTestViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 09/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMTestViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface GMTestViewController () <WCSessionDelegate>

@end

@implementation GMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initWCSession];
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

- (IBAction)onRoadworksDetected:(UIButton *)sender {
    NSLog(@"onRoadworksDetected");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"danger" : @"roadwork"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onTraficLightDetected:(UIButton *)sender {
    NSLog(@"onTraficLightDetected");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"danger" : @"trafic_light"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onDirectionLeft:(id)sender {
    NSLog(@"onDirectionLeft");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"itinary" : @"gauche"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onDirectionDirectly:(id)sender {
    NSLog(@"onDirectionDirectly");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"itinary" : @"toutdroit"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onDirectionRight:(id)sender {
    NSLog(@"onDirectionRight");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"itinary" : @"droite"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onDistance100m:(id)sender {
    NSLog(@"onDistance100m");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"itinary" : @"100m"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onDistance200m:(id)sender {
    NSLog(@"onDistance200m");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"itinary" : @"200m"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onDistance300m:(id)sender {
    NSLog(@"onDistance300m");
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"itinary" : @"300m"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (IBAction)onFinish:(id)sender {
    NSLog(@"onFinish");
    
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{@"isFinish" : @"true"}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
