//
//  PostCell.h
//  Instagram
//
//  Created by antiriby on 7/9/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) UIImageView *postImage;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UILabel *caption;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
