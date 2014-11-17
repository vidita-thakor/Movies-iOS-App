//
//  MovieListViewController.h
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MovieListViewController : UITableViewController <CLLocationManagerDelegate,UISearchBarDelegate>
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) NSArray *movieList;

@property (nonatomic, retain) NSData *Rawdata;
@property (nonatomic, retain) NSArray *filteredMovieList;

@property (nonatomic, retain) CLLocationManager *locationManager;
@end
