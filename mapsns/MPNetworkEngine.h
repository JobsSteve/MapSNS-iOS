//
//  MPNetworkEngine.h
//  mapsns
//
//  Created by 温盛章 on 13-2-14.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHttpRequest.h"
#import "MPResponseDelegate.h"

@interface MPNetworkEngine : NSObject <ASIHTTPRequestDelegate>{
    
}
+ (MPNetworkEngine *) sharedInstance;
- (void) enqueWithRequest:(ASIHTTPRequest *) request withDelegate:(id<MPResponseDelegate>) delegate withTaskId:(NSString * const) taskId;
@end
