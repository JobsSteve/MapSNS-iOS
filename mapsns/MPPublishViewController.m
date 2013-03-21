//
//  MPPublishViewController.m
//  mapsns
//
//  Created by 温盛章 on 13-2-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPPublishViewController.h"

@interface MPPublishViewController () {
    CLLocationManager *locationManager;
    UIAlertView *waitAlertView;
    NSUserDefaults *userDefaults;
    MPTimelineAPI *timelineAPI;
    NSString *token;
}

@end

@implementation MPPublishViewController

@synthesize publishTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    waitAlertView = [[UIAlertView alloc] init];
    timelineAPI = [[MPTimelineAPI alloc] initWithDelegate:self];
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userData = [userDefaults objectForKey:@"user_data"];
    
    token = [userData objectForKey:@"token"];
    
    [publishTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGRect publishTextViewRect = [publishTextView frame];
    
    publishTextViewRect.size.height -= keyboardRect.size.height;

    [publishTextView setFrame:publishTextViewRect];
    
}

- (void) keyboardWillHide:(NSNotification *)notification {
    
}

- (IBAction) publish:(id)sender {
    [waitAlertView show];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = CGPointMake(waitAlertView.bounds.size.width / 2.0f, waitAlertView.bounds.size.height / 2.0f);
    [indicator startAnimating];
    [waitAlertView addSubview:indicator];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSString *text = [publishTextView text];
    
    [timelineAPI publishTextTimeLine:text withToken:token withCoordinate:&coordinate];

}

- (IBAction) cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) requestDidReturnWithData:(NSDictionary *)data withTaskId:(NSString *)taskId error:(NSError *)error {
    [waitAlertView dismissWithClickedButtonIndex:0 animated:true];
    error = [self handlerErrorWithData:data andExtraError:error];
    if( error ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    [self cancel:nil];
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

@end
