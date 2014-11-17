//
//  SearchViewController.m
//  MovieBuzz
//
//  Created by Mac User 1 on 10/30/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "SearchViewController.h"
#import "HomeViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Search";
        self.tabBarItem.tag = 5;
        self.tabBarItem.image = [UIImage imageNamed:@"Magnify"];
        // UITextView *textView = [UITextView ]
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
