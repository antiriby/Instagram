//
//  PostCell.m
//  Instagram
//
//  Created by antiriby on 7/9/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import "DateTools.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)setPost:(Post *)post{
    _post = post;
    
    self.topUsernameLabel.text = self.post[@"author"][@"username"];
    self.bottomUsernameLabel.text = self.post[@"author"][@"username"];
    self.captionLabel.text = self.post[@"caption"];
    NSDate *createdAtDate= self.post.createdAt;
    // Convert Date to String
    self.timestampLabel.text = [createdAtDate timeAgoSinceNow];
    
    PFFileObject *img = post.image;
    [img getDataInBackgroundWithBlock:^(NSData *  imageData, NSError * error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [self resizeImage:imageToLoad withSize:CGSizeMake(400, 400)];
        [self.postImageView setImage:imageToLoad];
    }];
}

@end
