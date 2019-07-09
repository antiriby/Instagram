//
//  AppDelegate.h
//  Instagram
//
//  Created by antiriby on 7/8/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ComposeViewControllerDelegate

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;

@end

