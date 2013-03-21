//
//  MPUserModel.h
//  mapsns
//
//  Created by 温盛章 on 13-2-16.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPBaseModel.h"

@interface MPUserModel : MPBaseModel

@property(strong,nonatomic) NSNumber *userId;
@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *nickName;
@property(strong,nonatomic) NSString *token;
@end
