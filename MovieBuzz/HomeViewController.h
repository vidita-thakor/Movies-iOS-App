//
//  HomeViewController.h
//  MovieBuzz
//
//  Created by Abhishek Desai on 10/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@class MovieManager;
@interface HomeViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
	UIScrollView* scrollView;
	UIPageControl* pageControl;
	//IBOutlet UITableView *mytableView;
	BOOL pageControlBeingUsed;
    IBOutlet UITableView *myTableView;
}

@property(nonatomic,retain) NSArray* _movies;
@property(nonatomic,retain) MovieManager* _manager;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
//@property (retain, nonatomic) UITableView *mytableView;
//@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, retain) UITableView *myTableView;


- (IBAction)changePage:(id)sender;

@end
