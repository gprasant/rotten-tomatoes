//
//  MovieDetailsViewController.h
//  RottenTomatoes
//
//  Created by Prasanth Guruprasad on 10/25/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImgView;
@property (weak, nonatomic) IBOutlet UITextView *synopsisTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *synopsisScrollView;


@property (strong, nonatomic) NSURL *posterImgUrl;
@property (strong, nonatomic) NSString *synopsisText;

@end
