//
//  MovieShowTimeViewController.m
//  MovieBuzz
//
//  Created by Harmony Public Schools on 12/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "MovieShowTimeViewController.h"
#import "MovieShowTimeTableCell.h"
#import "MovieShowTime.h"
@interface MovieShowTimeViewController ()

@end

@implementation MovieShowTimeViewController
@synthesize tmsId, title, moviesShowTime, theatreList,listofshowtimes,listoftheatres;

-(void) dealloc {
    [super dealloc];
    [tmsId release];
    [title release];
    [moviesShowTime release];
    [theatreList release];
    [listoftheatres release];
    [listofshowtimes release];
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Movie Show Time";
    NSMutableArray* list_t=[[NSMutableArray alloc]init];
    NSMutableArray* list_s=[[NSMutableArray alloc]init];
    NSMutableArray* tempshowtimes=[[[NSMutableArray alloc]init]autorelease];
    for(int i=0;i<moviesShowTime.count;i++)
    {
        NSDictionary* showtimeofmovie= [moviesShowTime objectAtIndex:i];
        
        NSDictionary* theatre= [showtimeofmovie objectForKey:@"theatre"];
        
        NSArray *time = [[showtimeofmovie objectForKey:@"dateTime"] componentsSeparatedByString:@"T"];
        
        NSString* theatrename = [NSString stringWithFormat:@"%@",[theatre objectForKey:@"name"]];
        
       NSString* showtimes = [NSString stringWithFormat:@"%@",[time objectAtIndex:1]];
        if(i==0)
        {
            [list_t addObject:theatrename];
        }
        if(([list_t containsObject:theatrename]==FALSE))
        {
            [list_t addObject:theatrename];
            NSString* shwtimestr=[tempshowtimes componentsJoinedByString:@","];
            [list_s addObject:shwtimestr];
            tempshowtimes = nil;
        }
        else
        {
            [tempshowtimes addObject:showtimes];
        }
        if(i==moviesShowTime.count-1)
        {
            NSString* shwtimestr=[tempshowtimes componentsJoinedByString:@","];
            [list_s addObject:shwtimestr];
        }
    }

    
    self.listoftheatres=list_t;
    self.listofshowtimes=list_s;
    [list_t release];
    [list_s release];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = [NSString stringWithFormat:@"%@", title];
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%lu",(unsigned long)[moviesShowTime count]);
    return [self.listoftheatres count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MovieShowTimeTableCell *cell = (MovieShowTimeTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MovieShowTimeTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cell...
    /*
    NSDictionary* showtimeofmovie= [moviesShowTime objectAtIndex:indexPath.row];
    
    NSDictionary* theatre= [showtimeofmovie objectForKey:@"theatre"];
    
    NSArray *time = [[showtimeofmovie objectForKey:@"dateTime"] componentsSeparatedByString:@"T"];
    */
    cell.theatreName.text = [NSString stringWithFormat:@"%@",[self.listoftheatres objectAtIndex:indexPath.row]];
    
    cell.movieShowTime.text = [NSString stringWithFormat:@"%@",[self.listofshowtimes objectAtIndex:indexPath.row]];
    
   
    
    
    
    
    return cell;
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
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
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
