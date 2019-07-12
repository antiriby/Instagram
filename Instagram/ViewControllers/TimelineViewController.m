//
//  TimelineViewController.m
//  Instagram
//
//  Created by antiriby on 7/8/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import "PostCell.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "ComposeViewController.h"
#import "LoginViewController.h"
#import "TimelineViewController.h"
#import "DetailsViewController.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic)UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Initialize mutable array
    self.posts = [[NSMutableArray alloc] init];
    
    //Set tableview datasource and delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //Refresh Indicatior
    self.refreshControl  = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    //Make database request
    [self fetchPosts];
}

#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"toDetails"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.post = post;
    }
}

#pragma mark - IBAction
- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        if(error){
            NSLog(@"Error: %@", error.description);
        } else {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
        }
    }];
}

- (IBAction)didTapLIke:(id)sender {
}

#pragma mark - Parse requests
-(void)fetchPosts{
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 10;
    
    // fetch data asynchronously
    //This is so the app does not stall while you are fetching the data from Parse
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            NSLog(@"Successfully pulled posts!");
            self.posts = (NSMutableArray *)posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else {
            // handle error
            NSLog(@"Error: %@", error.description);
        }
    }];
}

-(void)loadMoreData{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.skip = self.posts.count;
    postQuery.limit = 10;
    
    // fetch data asynchronously
    //This is so the app does not stall while you are fetching the data from Parse
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
             self.isMoreDataLoading = false;
            NSLog(@"Successfully pulled posts!");
            [self.posts addObjectsFromArray:posts];
            [self.tableView reloadData];
            //[self.refreshControl endRefreshing];
        }
        else {
            // handle error
            NSLog(@"Error: %@", error.description);
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadMoreData];
        }
    }
}

#pragma mark - UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
