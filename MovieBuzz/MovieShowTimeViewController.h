//
//  MovieShowTimeViewController.h
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MovieShowTimeTableCell.h"
//#import "MoviereShowTime.h"
#import "MovieManager.h"
#import "MovieCommunicator.h"
#import <CoreLocation/CoreLocation.h>

@interface MovieShowTimeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSString *tmsId;
@property (nonatomic, retain) NSString *title;

@property(nonatomic,retain) NSArray* moviesShowTime;
@property (nonatomic, retain) NSArray *theatreList;


@property(strong,nonatomic) NSMutableArray* listoftheatres;
@property(strong,nonatomic) NSMutableArray* listofshowtimes;
@end
