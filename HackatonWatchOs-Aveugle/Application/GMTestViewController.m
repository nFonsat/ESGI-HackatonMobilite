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

- (void) sendMessageToWatchWithKey:(NSString *)key value:(NSString*)value {
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{key:value}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}


#pragma mark - Action User interface impl

- (IBAction)onReadyAction:(UIButton *)sender {
    NSLog(@"onReadyAction");
    [self sendMessageToWatchWithKey:@"isReady" value:@"true"];
}

- (IBAction)onRoadworksDetected:(UIButton *)sender {
    NSLog(@"onRoadworksDetected");
    [self sendMessageToWatchWithKey:@"danger" value:@"roadwork"];
}

- (IBAction)onTraficLightDetected:(UIButton *)sender {
    NSLog(@"onTraficLightDetected");
    [self sendMessageToWatchWithKey:@"danger" value:@"trafic_light"];
}

- (IBAction)onDirectionLeft:(id)sender {
    NSLog(@"onDirectionLeft");
    [self sendMessageToWatchWithKey:@"direction" value:@"gauche"];
}

- (IBAction)onDirectionDirectly:(id)sender {
    NSLog(@"onDirectionDirectly");
    [self sendMessageToWatchWithKey:@"direction" value:@"toutdroit"];
}

- (IBAction)onDirectionRight:(id)sender {
    NSLog(@"onDirectionRight");
    [self sendMessageToWatchWithKey:@"direction" value:@"droite"];
}

- (IBAction)onDistance100m:(id)sender {
    NSLog(@"onDistance100m");
    [self sendMessageToWatchWithKey:@"distance" value:@"100m"];
}

- (IBAction)onDistance200m:(id)sender {
    NSLog(@"onDistance200m");
    [self sendMessageToWatchWithKey:@"distance" value:@"200m"];
}

- (IBAction)onDistance300m:(id)sender {
    NSLog(@"onDistance300m");
    [self sendMessageToWatchWithKey:@"distance" value:@"300m"];
}

- (IBAction)onFinish:(id)sender {
    NSLog(@"onFinish");
    [self sendMessageToWatchWithKey:@"isFinish" value:@"true"];
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
