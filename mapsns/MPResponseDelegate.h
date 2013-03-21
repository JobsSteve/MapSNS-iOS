//
//  MPResponseDelegate.h
//  mapsns
//
//  Created by 温盛章 on 13-2-14.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MPResponseDelegate <NSObject>
@required
-(void) requestDidReturnWithData:(NSDictionary *) data withTaskId:(NSString *) taskId error:(NSError *) error;
@end
