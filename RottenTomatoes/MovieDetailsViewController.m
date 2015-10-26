//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Prasanth Guruprasad on 10/25/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.synopsisTextView setText:self.synopsisText];
    [self.postImgView setImageWithURL:self.posterImgUrl];

    // scroll view setup
    [self.synopsisTextView sizeToFit];
    CGFloat width = self.synopsisScrollView.bounds.size.width;
    CGFloat height = self.synopsisScrollView.bounds.size.height;
    [self.synopsisScrollView setScrollEnabled:YES];
    self.synopsisScrollView.contentSize = CGSizeMake(width, height);
    [self.synopsisScrollView addSubview:self.synopsisTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
