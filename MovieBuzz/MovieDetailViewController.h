//
//  MovieDetailViewController.h
//  MovieBuzz
//
//  Created by Abhishek Desai on 10/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Movies.h"

@interface MovieDetailViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *poster;
@property (retain, nonatomic) Movies *moviedetail;
@property (retain, nonatomic) IBOutlet UILabel *movieTitle;

@property (retain, nonatomic) IBOutlet UILabel *duration;
@property (retain, nonatomic) IBOutlet UITextView *topcast;


@property (retain, nonatomic) IBOutlet UITextView *description;
@property (retain, nonatomic) IBOutlet UILabel *rated;

@property (retain, nonatomic) IBOutlet UILabel *runningTime;
@property (retain, nonatomic) IBOutlet UILabel *genre;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;


- (IBAction)playTrailer:(id)sender;
- (IBAction)showTimes:(id)sender;

@end
