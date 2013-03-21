//
//  MPStatusModel.m
//  mapsns
//
//  Created by 温盛章 on 13-2-16.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPStatusModel.h"

@implementation MPStatusModel

@synthesize author;
@synthesize statusId;
@synthesize statusContent;
@synthesize statusType;

@synthesize updateTime;

- (id) initWithDictionary:(NSDictionary *)dic {
    self = [self init];
    if ( self ) {
        NSDictionary *authorDic = [dic objectForKey:@"author"];
        self.author = [[MPUserModel alloc] initWithDictionary:authorDic];
        self.statusId = [dic objectForKey:@"id"];
        self.statusContent = [dic objectForKey:@"statusContent"];
        self.statusType = [dic objectForKey:@"statusType"];
        self.updateTime = [dic objectForKey:@"updateTime"];
        self.latitude = [dic objectForKey:@"latitude"];
        self.longitude = [dic objectForKey:@"longitude"];
    }
    return self;
}
@end
