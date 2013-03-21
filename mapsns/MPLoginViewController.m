//
//  MPViewController.m
//  mapsns
//
//  Created by 温盛章 on 13-2-13.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPLoginViewController.h"

@interface MPLoginViewController () {
    UIAlertView *waitAlertView;
    NSUserDefaults *userDefaults;
}

@end

@implementation MPLoginViewController

@synthesize mUserNameTextView;
@synthesize mPassWordTextView;
@synthesize mLoginBtn;
@synthesize mUserAPI;
- (void)viewDidLoad
{
    [super viewDidLoad];
    userDefaults = [NSUserDefaults standardUserDefaults];
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSDictionary *dic = [userDefaults objectForKey:@"user_data"];
    if( !dic ) {
        [mUserNameTextView setDelegate:self];
        [mPassWordTextView setDelegate:self];
        mUserAPI = [[MPUserAPI alloc] initWithDelegate:self];
        waitAlertView = [[UIAlertView alloc] init];
    } else {
        [self performSegueWithIdentifier:@"EnterMapView" sender:self];
    }
}
- (IBAction) loginBtnClick:(id)sender {
    [waitAlertView show];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = CGPointMake(waitAlertView.bounds.size.width / 2.0f, waitAlertView.bounds.size.height / 2.0f);
    [indicator startAnimating];
    [waitAlertView addSubview:indicator];
    NSString *userName = [mUserNameTextView text];
    NSString *password = [mPassWordTextView text];
    [mUserAPI loginWithUserName:userName withPassword:password];
   
}

- (IBAction) textFieldDoneEditing:(id)sender {
    [mUserNameTextView resignFirstResponder];
    [mPassWordTextView resignFirstResponder];
}

/* use to let keyboard not overlay the button */
-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    int movement = (up? -movementDistance : movementDistance);
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if( textField == mUserNameTextView ) {
        [mPassWordTextView becomeFirstResponder];
    } else {
        [self loginBtnClick:mLoginBtn];
    }
    return true;
}

- (void) requestDidReturnWithData:(NSDictionary *)data withTaskId:(NSString *)taskId error:(NSError *)error {
    [waitAlertView dismissWithClickedButtonIndex:0 animated:true];
    error = [self handlerErrorWithData:data andExtraError:error];
    if( error ) {
        [self showError:error];
        return ;
    }
    userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:@"user_data"];
    [userDefaults synchronize];
    
    [self performSegueWithIdentifier:@"EnterMapView" sender:self];

}

- (void) showError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] init];
    NSString *title = [error description];
    [alertView setTitle:title];
    [alertView addButtonWithTitle:@"知道了"];
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

@end
