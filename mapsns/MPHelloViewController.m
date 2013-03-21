//
//  MPHelloControllerViewController.m
//  mapsns
//
//  Created by 温盛章 on 13-3-15.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import "MPHelloViewController.h"

@interface MPHelloViewController () {
    NSUserDefaults *userDefaults;
}

@end

@implementation MPHelloViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self performSegueWithIdentifier:@"EnterLoginView" sender:self];
    });
}

- (void)viewDidAppear:(BOOL)animated {
    NSDictionary *dic = [userDefaults objectForKey:@"user_data"];
    if( dic ) {
        [self performSegueWithIdentifier:@"EnterMapView" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
