//
//  MPBaseAPI.h
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPResponseDelegate.h"

@interface MPBaseAPI : NSObject

@property(weak, nonatomic) id<MPResponseDelegate> responseDelegate;

- (id) initWithDelegate:(id<MPResponseDelegate>)delegate;

@end
