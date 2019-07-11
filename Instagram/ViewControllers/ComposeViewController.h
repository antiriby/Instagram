//
//  ComposeViewController.h
//  Instagram
//
//  Created by antiriby on 7/9/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN
@protocol ComposeViewControllerDelegate

- (void)didPost:(Post *)post;

@end

@interface ComposeViewController : UIViewController

@property (strong, nonatomic)UIImage *passedImage;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UITextView *captionField;
@property (strong, nonatomic) id<ComposeViewControllerDelegate> delegate;

- (IBAction)didTapShare:(id)sender;

@end

NS_ASSUME_NONNULL_END
