//
//  MPPublishViewController.h
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MPTimelineAPI.h"
#import "MPResponseDelegate.h"

@interface MPPublishViewController : UIViewController <CLLocationManagerDelegate,MPResponseDelegate>

@property(strong, nonatomic) IBOutlet UITextView *publishTextView;

- (IBAction) cancel:(id)sender;
- (IBAction) publish:(id)sender;
@end
