//
//  MPTimelineAPI.h
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPBaseAPI.h"
#import "MPNetworkEngine.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "APIConfig.h"
#import <CoreLocation/CoreLocation.h>

@interface MPTimelineAPI : MPBaseAPI
- (void) getUserTimeLine:(NSString *) authtoken;

- (void) publishTextTimeLine:(NSString *)text withToken:(NSString *)token withCoordinate:(CLLocationCoordinate2D *)coordinate;
@end
