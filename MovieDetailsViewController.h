//
//  MovieDetailsViewController.h
//  RottenTomatoes
//
//  Created by Prasanth Guruprasad on 10/20/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImgView;

@property (weak, nonatomic) NSURL *posterImgUrl;
@property (strong, nonatomic) NSString *synopsisLabelText;

@end
