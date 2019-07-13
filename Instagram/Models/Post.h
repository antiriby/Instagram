//
//  Post.h
//  Instagram
//
//  Created by antiriby on 7/9/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN
@interface Post : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *postID;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) PFUser *author;

@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) PFFileObject *image;
@property (strong, nonatomic) NSNumber *likeCount;
@property (strong, nonatomic) NSNumber *commentCount;
@property (strong, nonatomic) NSMutableArray *peopleLiked;

+ (Post *) postUserImage:(UIImage * _Nullable)image withCaption:(NSString * _Nullable)caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
