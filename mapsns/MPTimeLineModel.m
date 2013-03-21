//
//  MPTimeLineModel.m
//  mapsns
//
//  Created by 温盛章 on 13-2-16.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPTimeLineModel.h"

@implementation MPTimeLineModel

@synthesize status;

- (id) initWithDictionary:(NSDictionary *)dic {
    self = [self init];
    if( self ) {
        NSArray *statusArray = [dic objectForKey:@"status"];
        NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
        for( NSDictionary *dic in statusArray ) {
            MPStatusModel *statusModel = [[MPStatusModel alloc] initWithDictionary:dic];
            [tmpArray addObject:statusModel];
        }
        [self setStatus:tmpArray];
    }
    return self;
}
@end
