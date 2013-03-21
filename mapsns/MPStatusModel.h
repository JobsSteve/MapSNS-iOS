//
//  MPStatusModel.h
//  mapsns
//
//  Created by 温盛章 on 13-2-16.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPUserModel.h"
@interface MPStatusModel : MPBaseModel

@property(strong,nonatomic) NSNumber *statusId;
@property(strong,nonatomic) MPUserModel *author;
@property(strong,nonatomic) NSString *statusContent;
@property(strong,nonatomic) NSNumber *statusType;
@property(strong,nonatomic) NSNumber *updateTime;
@property(strong,nonatomic) NSNumber *latitude;
@property(strong,nonatomic) NSNumber *longitude;
@end
