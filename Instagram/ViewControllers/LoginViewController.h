//
//  LoginViewController.h
//  Instagram
//
//  Created by antiriby on 7/8/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

-(void)loginUser;
@end

NS_ASSUME_NONNULL_END
