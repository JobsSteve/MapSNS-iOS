//
//  MPViewController.h
//  mapsns
//
//  Created by 温盛章 on 13-2-13.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPUserAPI.h"
#import "MPResponseDelegate.h"
#import "MPMapViewController.h"

@interface MPLoginViewController: UIViewController <UITextFieldDelegate,MPResponseDelegate>{

}
@property(strong, nonatomic) IBOutlet UITextField   *mUserNameTextView;
@property(strong, nonatomic) IBOutlet UITextField   *mPassWordTextView;
@property(strong, nonatomic) IBOutlet UIButton      *mLoginBtn;
@property(strong, nonatomic) MPUserAPI *mUserAPI;
@end
