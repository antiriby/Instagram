//
//  PostCell.m
//  Instagram
//
//  Created by antiriby on 7/9/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import "Post.h"
#import "PostCell.h"
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

#pragma mark - setPost
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
    
    self.likeButton.selected =[[self.post peopleLiked] containsObject:self.topUsernameLabel.text];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%@", self.post.likeCount]forState:UIControlStateNormal];
    
    PFFileObject *img = post.image;
    [img getDataInBackgroundWithBlock:^(NSData *  imageData, NSError * error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [self resizeImage:imageToLoad withSize:CGSizeMake(400, 400)];
        [self.postImageView setImage:imageToLoad];
    }];
}

#pragma mark - IBAction

- (IBAction)didTapLIke:(id)sender {
    NSString *username = self.post[@"author"][@"username"];
    if([self.post.peopleLiked containsObject:username]) {
        
    } else {
        //Increment number of likes
        int currentLikes = [[self.post likeCount] intValue];
        self.post.likeCount = [NSNumber numberWithInt:currentLikes + 1];
        currentLikes = [[self.post likeCount] intValue];
        
        //Add user to the array
        NSMutableArray *currentPeopleLiked = [[NSMutableArray alloc] init];
        [currentPeopleLiked addObjectsFromArray:[self.post peopleLiked]];
        [currentPeopleLiked addObject:username];
        self.post.peopleLiked = currentPeopleLiked;
        
        [self.post saveInBackgroundWithBlock:^(BOOL saved, NSError * _Nullable error){
            if(!error){
                NSLog(@"Successfully liked post");
                [self.likeButton setImage:[UIImage imageNamed:@"insta-like-icon-redd"] forState:UIControlStateNormal];
            } else {
                NSLog(@"Error");
            }
        }];
    }
    
    // TODO: Update cell UI
    [self.likeButton setTitle:[NSString stringWithFormat:@"%@", self.post.likeCount]forState:UIControlStateNormal];
    
}
@end
