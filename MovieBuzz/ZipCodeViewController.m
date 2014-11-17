//
//  ZipCodeViewController.m
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "ZipCodeViewController.h"
#import "AppDelegate.h"
#import "MovieListViewController.h"


@interface ZipCodeViewController ()

@end

@implementation ZipCodeViewController
@synthesize zipcodeTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Enter Zip Code";
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(gotoMenu)];
        self.navigationItem.leftBarButtonItem = doneBtn;
        
        UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(gotoListView)];
        
        self.navigationItem.rightBarButtonItem=nextBtn;
    }
    return self;
}
- (void) gotoMenu {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) gotoListView {
    //error check
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.zipCode=zipcodeTextField.text;
    MovieListViewController *movieListViewController= [[[MovieListViewController alloc] initWithNibName:@"MovieListViewController" bundle:[NSBundle mainBundle]] autorelease];
        [[self navigationController] pushViewController:movieListViewController animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.zipcodeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [zipcodeTextField release];
    [super dealloc];
}
@end
