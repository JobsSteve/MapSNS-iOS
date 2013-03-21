//
//  MPMapViewController.h
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MPResponseDelegate.h"
#import "MPTimelineAPI.h"
#import <MapKit/MapKit.h>
#import "MPTimeLineModel.h"

@interface MPMapViewController : UIViewController <CLLocationManagerDelegate,MPResponseDelegate,MKMapViewDelegate>

@property(strong,nonatomic) IBOutlet MKMapView *mapView;


-(IBAction) publishBtnClick:(id)sender;
@end
