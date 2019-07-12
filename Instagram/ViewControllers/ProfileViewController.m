//
//  ProfileViewController.m
//  Instagram
//
//  Created by antiriby on 7/11/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileImageView.layer.cornerRadius =  self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
