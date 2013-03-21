//
//  MPUserAPI.h
//  mapsns
//
//  Created by 温盛章 on 13-2-14.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConfig.h"
#import "MPNetworkEngine.h"
#import "ASIFormDataRequest.h"
#import "MPBaseAPI.h"

@interface MPUserAPI : MPBaseAPI

- (void) loginWithUserName:(NSString *)userName withPassword:(NSString *)password;

@end
