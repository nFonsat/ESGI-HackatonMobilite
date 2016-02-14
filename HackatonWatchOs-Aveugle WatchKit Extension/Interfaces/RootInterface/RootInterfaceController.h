//
//  RootInterfaceController.h
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface RootInterfaceController : WKInterfaceController

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message;

- (void)sendMessageToIphoneWithKey:(NSString *)key Value:(NSString*)value;

@end
