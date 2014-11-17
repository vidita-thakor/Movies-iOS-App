//
//  TheatreShowTimeViewController.h
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/7/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface TheatreShowTimeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int theatreId;
@property (nonatomic, retain) NSString *theatreName;
@property (nonatomic, assign) int movieRootId;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end
