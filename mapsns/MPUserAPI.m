//
//  MPUserAPI.m
//  mapsns
//
//  Created by 温盛章 on 13-2-14.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPUserAPI.h"

@implementation MPUserAPI
{
    MPNetworkEngine *networkEngine;
}
- (id) init {
    self = [super init];
    if( self ) {
        networkEngine = [MPNetworkEngine sharedInstance];
    }
    return self;
}

- (void) loginWithUserName:(NSString *)userName withPassword:(NSString *)password {
    NSString *userNameField = @"username";
    NSString *passwordField = @"password";
    
    NSURL *loginUrl = [NSURL URLWithString:USER_LOGIN_URL];
    
    ASIFormDataRequest *formDataRequest = [ASIFormDataRequest requestWithURL:loginUrl];
    
    [formDataRequest setPostValue:userName forKey:userNameField];
    [formDataRequest setPostValue:password forKey:passwordField];
    
    [networkEngine enqueWithRequest:formDataRequest withDelegate:[self responseDelegate] withTaskId:TASK_USER_LOGIN];
}


@end
