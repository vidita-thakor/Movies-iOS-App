//
//  DetailTheatreViewController.h
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/7/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"
#import "PlaceAnnotation.h"

@interface DetailTheatreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDictionary *details;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;


@end
