//
//  DangerInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "DangerInterfaceController.h"
#import "VibrationManager.h"

static NSString * const kAlertDanger    = @"alert";

static NSString * const kAlertTraffic   = @"trafic";

static NSString * const kAlertTmp       = @"temporary";

@interface DangerInterfaceController ()
{
    @private
    NSString * _type;
}

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton * dangerBtn;

@end

@implementation DangerInterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    _type = context;
}

- (void)willActivate
{
    [super willActivate];
    
    [[VibrationManager sharedInstance] playVibrationFaillure];
    
    if (_type != nil) {
        [self loadImageFromType:_type];
    }
}

- (IBAction)onFinishAlert
{
    [self dismissController];
}

- (void)loadImageFromType:(NSString *)type
{
    if ([type isEqualToString:kAlertTraffic]) {
        [self.dangerBtn setBackgroundImageNamed:@"trafic_light"];
    }
    else if ([type isEqualToString:kAlertDanger]) {
        [self.dangerBtn setBackgroundImageNamed:@"roadwork"];
    }
    else if ([type isEqualToString:kAlertTmp]) {
        [self.dangerBtn setBackgroundImageNamed:@"roadwork"];
    }
}

@end



