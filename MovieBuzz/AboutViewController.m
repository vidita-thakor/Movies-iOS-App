//
//  AboutViewController.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 10/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"About";
        self.tabBarItem.tag = 5;
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
       // UITextView *textView = [UITextView ]
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationBar *aNavigationBar = [[UINavigationBar alloc] initWithFrame:
                                       CGRectMake(0.0, 0.0, 320.0, 44.0)];
    aNavigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar = aNavigationBar;
    [aNavigationBar release];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"About"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    [navigationItem release];
    
    [self.view addSubview:navigationBar];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
