//
//  GMWatch.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 14/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kWatchReadyNavigation   = @"ready_navigation";

static NSString * const kWatchStartNavigation   = @"start_navigation";

static NSString * const kWatchStopNavigation    = @"stop_navigation";

static NSString * const kWatchIsFinish          = @"is_finish";

static NSString * const kWatchStepDistance      = @"step_distance";

static NSString * const kWatchStepDirection     = @"step_direction";

static NSString * const kWatchDestinationName   = @"destination_name";

static NSString * const kWatchDanger            = @"danger";


@interface GMWatch : NSObject

@end
