//
//  MPBaseAPI.m
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPBaseAPI.h"

@implementation MPBaseAPI

@synthesize responseDelegate;

- (id) initWithDelegate:(id<MPResponseDelegate>)delegate {
    self = [self init];
    if( self ) {
        [self setResponseDelegate:delegate];
    }
    return self;
}

@end
