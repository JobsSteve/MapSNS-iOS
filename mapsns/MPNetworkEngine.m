//
//  MPNetworkEngine.m
//  mapsns
//
//  Created by 温盛章 on 13-2-14.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPNetworkEngine.h"

@implementation MPNetworkEngine {
    NSOperationQueue *queue;
}


static MPNetworkEngine *instance;

- (id) init {
    self = [super init];
    if( self ) {
        [self initQueueIfNeed];
        return self;
    }
    return nil;
}

+ (MPNetworkEngine *) sharedInstance{
    @synchronized(self) {
        if( !instance ) {
            [MPNetworkEngine makeInstance];
        }
    }
    return instance;
}

+ (void)  makeInstance {
    @synchronized( self ) {
        instance = [[MPNetworkEngine alloc] init];
    }
}

- (void) enqueWithRequest:(ASIHTTPRequest *) request withDelegate:(id<MPResponseDelegate>) delegate withTaskId:(NSString * const) taskId {
    [self initQueueIfNeed];
    [request setDelegate:self];
    [request setTimeOutSeconds:30];
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    
    [userInfo setValue:delegate forKey:@"delegate" ];
    [userInfo setValue:taskId forKey:@"taskid"];
    [request setUserInfo:userInfo];
    [queue addOperation:request];

}

- (void) initQueueIfNeed {
    if( !queue ) {
        queue = [[NSOperationQueue alloc] init];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSDictionary *userInfo = [request userInfo];
    id<MPResponseDelegate> delegate = [userInfo objectForKey:@"delegate"];
    NSString *taskId = [userInfo objectForKey:@"taskid"];
    if( delegate ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate requestDidReturnWithData:nil withTaskId:taskId error:error];
        });
    }
}

- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data {
    NSError *parseError = nil;
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    NSDictionary *userInfo = [request userInfo];
    id<MPResponseDelegate> delegate = [userInfo objectForKey:@"delegate"];
    NSString *taskId = [userInfo objectForKey:@"taskid"];
    if( delegate ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate requestDidReturnWithData:responseData withTaskId:taskId error:nil];
        });
    }
}

@end
