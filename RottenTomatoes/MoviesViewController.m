//
//  ViewController.m
//  RottenTomatoes
//
//  Created by Prasanth Guruprasad on 10/20/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MoviesViewController.h"
#import "MoviesTableViewCell.h"
#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "GiFHUD.h"

@interface MoviesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

    NSString *urlString = @"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.title = @"Movies";
    // Refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self fetchMovies];
}

-
(void) fetchMovies {

    NSURL *url = [NSURL URLWithString:urlString];
    [self.refreshControl endRefreshing];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForResource = 4;
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration: sessionConfig
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    [GiFHUD setGifWithImageName: @"pika.gif"];
    [self.errorNotifierView setHidden:YES];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                   // [self.errorNotifierView removeFromSuperview]; // remove error view
                                                    
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    self.movies = responseDictionary[@"movies"];
                                                    
                                                    [self.tableView reloadData];
                                                    [self.refreshControl endRefreshing];
                                                    [GiFHUD dismiss];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                    [GiFHUD dismiss];
                                                    [self.errorNotifierView setHidden:NO];
                                                }
                                            }];
    [GiFHUD showWithOverlay];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesTableViewCell *vCell = [self.tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    vCell.titleLabel.text = self.movies[indexPath.row][@"title"];
    vCell.synopsisLabel.text = self.movies[indexPath.row][@"synopsis"];
    NSURL *imageUrl = [NSURL URLWithString: self.movies[indexPath.row][@"posters"][@"thumbnail"]];
//    NSLog([imageUrl absoluteString]);
    [vCell.posterImgView setImageWithURL: imageUrl];
    return vCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieDetailsViewController *mdvc = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForCell: sender];
    mdvc.posterImgUrl = [NSURL URLWithString: self.movies[indexPath.row][@"posters"][@"detailed"]];
    mdvc.synopsisText = self.movies[indexPath.row][@"synopsis"];
    [mdvc.synopsisTextView setText:mdvc.synopsisText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
