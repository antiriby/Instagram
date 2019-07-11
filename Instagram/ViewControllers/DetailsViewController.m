//
//  DetailsViewController.m
//  Instagram
//
//  Created by antiriby on 7/10/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import "DetailsViewController.h"
#import "Parse/Parse.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usernameLabel.text = [NSString stringWithFormat:@"User: %@",self.post[@"author"][@"username"]];
    self.captionLabel.text = self.post[@"caption"];
    
    NSDate *createdAtDate= self.post.createdAt;
    // Convert Date to String
    self.timestampLabel.text = [createdAtDate timeAgoSinceNow];

    PFFileObject *img = self.post.image;
    [img getDataInBackgroundWithBlock:^(NSData *  imageData, NSError * error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [self.postImageView setImage:imageToLoad];
    }];
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
