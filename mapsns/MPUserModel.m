//
//  MPUserModel.m
//  mapsns
//
//  Created by 温盛章 on 13-2-16.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPUserModel.h"

@implementation MPUserModel

@synthesize userId;
@synthesize userName;
@synthesize nickName;
@synthesize token;

- (id) initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if( self ) {
        self.userId = [dic objectForKey:@"id"];
        self.nickName = [dic objectForKey:@"nickName"];
        self.userName = [dic objectForKey:@"userName"];
        self.token = [dic objectForKey:@"token"];
    }
    return self;
}
@end
