//
//  TimelineViewController.h
//  Instagram
//
//  Created by antiriby on 7/8/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimelineViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImage *photoImage;
@property (strong, nonatomic) NSArray *posts;

- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapCamera:(id)sender;

@end

NS_ASSUME_NONNULL_END
