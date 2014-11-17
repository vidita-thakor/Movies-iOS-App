//
//  TestViewController.h
//  MovieBuzz
//
//  Created by Mac User 1 on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheatreListViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (retain, nonatomic) IBOutlet UISearchBar *ssearchBar;
@property (nonatomic, retain) NSArray *filteredTheatreList;
@end
