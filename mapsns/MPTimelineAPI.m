//
//  MPTimelineAPI.m
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPTimelineAPI.h"

@implementation MPTimelineAPI {
    MPNetworkEngine *networkEngine;
}

- (id) init {
    self = [super init];
    if( self ) {
        networkEngine = [MPNetworkEngine sharedInstance];
    }
    return self;
}

- (void) getUserTimeLine:(NSString *)authtoken {
    NSString *getUserTimeLineUrlString = [TIMELINE_USER_URL stringByAppendingFormat:@"?token=%@",authtoken];
    NSURL *getUserTimeLineUrl = [NSURL URLWithString:getUserTimeLineUrlString];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL: getUserTimeLineUrl];

    [networkEngine enqueWithRequest:request withDelegate:[self responseDelegate] withTaskId:TASK_TIMELINE_USER];
}

- (void) publishTextTimeLine:(NSString *)text withToken:(NSString *)token withCoordinate:(CLLocationCoordinate2D *)coordinate {
    NSURL *publishTextUrl = [NSURL URLWithString:TIMELINE_PUBLISH_TEXT];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:publishTextUrl];
    
    CLLocationDegrees latitude = coordinate->latitude;
    CLLocationDegrees longitude = coordinate->longitude;
    
    NSNumber *latitudeNumber = [[NSNumber alloc] initWithDouble:latitude];
    NSNumber *longitudeNumber = [[NSNumber alloc] initWithDouble:longitude];
    
    [request setPostValue:token forKey:@"token"];
    [request setPostValue:text forKey:@"content"];
    [request setPostValue:latitudeNumber forKey:@"latitude"];
    [request setPostValue:longitudeNumber forKey:@"longitude"];
    
    [networkEngine enqueWithRequest:request withDelegate:[self responseDelegate] withTaskId:TASK_TIMELINE_PUBLISH_TEXT];
}
@end
