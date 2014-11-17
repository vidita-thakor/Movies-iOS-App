//
//  MovieDetail2ViewController.m
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "MovieDetail2ViewController.h"
#import "AppDelegate.h"
@interface MovieDetail2ViewController ()

@end

@implementation MovieDetail2ViewController
@synthesize tmsId,theatreList;
- (void)dealloc {
    [tmsId release];
    [theatreList release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadTheatreList];
}
-(void)loadTheatreList
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.searchByCurrentLocation==YES)
    {
        NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%f%@%f%@", @"http://data.tmsapi.com/v1/movies/",self.tmsId, @"/showings?startDate=",[DateFormatter stringFromDate:[NSDate date]],@"&lat=",appDelegate.latitude,@"&lng=",appDelegate.longitude,@"&api_key=5dmhgfxxzv2y43kwhuzv8ap8"];
        //NSLog(@"%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *jasonParsingError = nil;
        
        NSArray *jasonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jasonParsingError];
        
        if([jasonArray count]>0)
        {
            self.theatreList= [[jasonArray objectAtIndex:0] objectForKey:@"showtimes"];
        }
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", @"http://data.tmsapi.com/v1/movies/",self.tmsId, @"/showings?startDate=",[DateFormatter stringFromDate:[NSDate date]],@"&zip=",appDelegate.zipCode,@"&api_key=5dmhgfxxzv2y43kwhuzv8ap8"];
        //NSLog(@"%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *jasonParsingError = nil;
        
        NSArray *jasonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jasonParsingError];
        
        if([jasonArray count]>0)
        {
            self.theatreList= [[jasonArray objectAtIndex:0] objectForKey:@"showtimes"];
        }
    }
    [DateFormatter release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [theatreList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSDictionary* showtimeofmovie= [theatreList objectAtIndex:indexPath.row];
    NSDictionary* theatre= [showtimeofmovie objectForKey:@"theatre"];
    
    NSArray *time = [[showtimeofmovie objectForKey:@"dateTime"] componentsSeparatedByString:@"T"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[theatre objectForKey:@"name"]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.textLabel.numberOfLines = 1;
    [cell.textLabel adjustsFontSizeToFitWidth];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[time objectAtIndex:1]];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.numberOfLines = 2;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 60;
    
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
