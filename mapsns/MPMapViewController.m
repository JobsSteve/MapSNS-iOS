//
//  MPMapViewController.m
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPMapViewController.h"

@interface MPMapViewController () {
    CLLocationManager *locationManager;
    MPTimelineAPI *timelineAPI;
    NSUserDefaults *userDefaults;
    NSString *token;
    NSArray *pinAnnotationArray;
}

@end

@implementation MPMapViewController
@synthesize mapView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager startUpdatingLocation];
    userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userData = [userDefaults objectForKey:@"user_data"];
    token = [userData objectForKey:@"token"];
    timelineAPI = [[MPTimelineAPI alloc] initWithDelegate:self];
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [self loadData];
    [self initMapView];
}

- (void) initMapView {
//    CLLocation *location = [locationManager location];
//    [mapView setCenterCoordinate:[location coordinate] animated:YES];
//    [mapView setMapType:MKMapTypeStandard];
//    [mapView setShowsUserLocation:YES];
}

- (void) loadData {
    [timelineAPI getUserTimeLine:token];
}

- (void) requestDidReturnWithData:(NSDictionary *)data withTaskId:(NSString *)taskId error:(NSError *)error {
    error = [self handlerErrorWithData:data andExtraError:error];
    if( error) {
        [self handleError:error];
        return;
    }
    MPTimeLineModel *timeLineModel = [[MPTimeLineModel alloc] initWithDictionary:data];
    [self setupMapAnnotation:timeLineModel];
}

- (void) setupMapAnnotation:(MPTimeLineModel *)timelineModel {
    NSArray *statusArray = [timelineModel status];
    [mapView removeAnnotations:pinAnnotationArray];
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for( MPStatusModel *model in statusArray ) {
        NSNumber *latitude = [model latitude];
        NSNumber *longitude = [model longitude];
        if( latitude && longitude ) {
            MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
            [ann setCoordinate:CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue])];
            [ann setTitle:[[model author] nickName]];
            [ann setSubtitle:[model statusContent]];
            [tmpArray addObject:ann];
        }
    }
    pinAnnotationArray = [tmpArray copy];
    [mapView addAnnotations:pinAnnotationArray];
}

- (void) handleError:(NSError *) error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[error debugDescription] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertView show];
}

- (NSError *) handlerErrorWithData:(NSDictionary *)data andExtraError:(NSError *)error {
    if( error ) {
        return error;
    }
    NSNumber *codeNumber = [data objectForKey:@"errorCode"];
    int code = [codeNumber intValue];
    if( code != 0 ) {
        error = [[NSError alloc] init];
    }
    return error;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    return nil;
}


- (IBAction) publishBtnClick:(id)sender {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
