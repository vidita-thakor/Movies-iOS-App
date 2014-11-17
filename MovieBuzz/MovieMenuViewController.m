//
//  MovieMenuViewController.m
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "MovieMenuViewController.h"
#import "ZipCodeViewController.h"
#import "MovieListViewController.h"
#import "AppDelegate.h"


@interface MovieMenuViewController ()

@end

@implementation MovieMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Search";
        self.tabBarItem.tag = 4;
        self.tabBarItem.image = [UIImage imageNamed:@"Magnify"];
    }
    return self;
}
-(void) dealloc{
    //[locationOrZipcodeAlertView release];
    [super dealloc];
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  ///  [locationOrZipcodeAlertView show];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*
    locationOrZipcodeAlertView= [[UIAlertView alloc] initWithTitle:@""
                                                           message:@"Search by Location or Zipcode" delegate:self
                                                 cancelButtonTitle:@"Location"
                                                 otherButtonTitles:@"Zip Code", nil];*/
    
}
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.searchByMovie=YES;
    
    if (buttonIndex == 0)
    {
        appDelegate.searchByCurrentLocation=YES;
        appDelegate.zipCode=@"";
        
        
        MovieListViewController *movieListViewController = [[[MovieListViewController alloc] initWithNibName:@"MovieListViewController" bundle:[NSBundle mainBundle]]autorelease];
        [[self navigationController] pushViewController:movieListViewController animated:YES];
       
        
    }
    else if (buttonIndex == 1)
    {
        appDelegate.searchByCurrentLocation=NO;
        
        ZipCodeViewController *zipCodeViewController = [[[ZipCodeViewController alloc] initWithNibName:@"ZipCodeViewController" bundle:[NSBundle mainBundle]]autorelease];
        [[self navigationController] pushViewController:zipCodeViewController animated:YES];
       
        
    }
    
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchByLocation:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.searchByMovie=YES;
    appDelegate.searchByCurrentLocation=YES;
    appDelegate.zipCode=@"";
    
    MovieListViewController *movieListViewController = [[[MovieListViewController alloc] initWithNibName:@"MovieListViewController" bundle:[NSBundle mainBundle]]autorelease];
    [[self navigationController] pushViewController:movieListViewController animated:YES];
}

- (IBAction)searchByZipcode:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.searchByMovie=YES;
    appDelegate.searchByCurrentLocation=NO;
    ZipCodeViewController *zipCodeViewController = [[[ZipCodeViewController alloc] initWithNibName:@"ZipCodeViewController" bundle:[NSBundle mainBundle]]autorelease];
    [[self navigationController] pushViewController:zipCodeViewController animated:YES];
}
@end
