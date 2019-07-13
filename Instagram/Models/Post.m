//
//  Post.m
//  Instagram
//
//  Created by antiriby on 7/9/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic peopleLiked;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (Post *) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = [NSNumber numberWithInt:0];
    newPost.commentCount = [NSNumber numberWithInt:0];
    newPost.peopleLiked = [[NSMutableArray alloc] init];
    
    [newPost saveInBackgroundWithBlock: completion];
    
    return newPost;
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
