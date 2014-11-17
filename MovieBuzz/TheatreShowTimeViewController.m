//
//  TheatreShowTimeViewController.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/7/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "TheatreShowTimeViewController.h"
#import "TheatreShowTimeTableCell.h"
#import "TheatreShowTime.h"
#import "MovieManager.h"
#import "MovieCommunicator.h"

@interface TheatreShowTimeViewController ()
@property(nonatomic,retain) NSArray* _theatresShowTime;
@property(nonatomic,retain) MovieManager* _manager;
@property (nonatomic, retain) NSArray *dataList;
@end

@implementation TheatreShowTimeViewController
@synthesize theatreId, theatreName, _manager, _theatresShowTime, movieRootId, moviePlayer, dataList;

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
    //self.title=[NSString stringWithFormat:@"%d",theatreId];
    self.title = @"Movie Show Time";
    _manager = [[[MovieManager alloc] init]autorelease];
    _manager.communicator = [[[MovieCommunicator alloc] init] autorelease];
    _manager.communicator.delegate = _manager;
    _manager.delegate = (id)self;
    [self startFetchingTheatresShowTime:theatreId];
    [self.tableView reloadData];
}

- (void)startFetchingTheatresShowTime:(int)theatreId
{
    [_manager fetchTheatresShowTime:self.theatreId];
}

- (void)didReceiveTheatresShowTime:(NSArray *)theatresShowTime
{
    self._theatresShowTime = theatresShowTime;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc {
    [super dealloc];
    [_manager release];
    [_theatresShowTime release];
    [moviePlayer release];
    [dataList release];
    [theatreName release];
}

#pragma mark - Table view data source


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = [NSString stringWithFormat:@"%@", theatreName];
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
    return _theatresShowTime.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TheatreShowTimeTableCell *cell = (TheatreShowTimeTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheatreShowTimeTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cell...
    TheatreShowTime *theatreShowTime = _theatresShowTime[indexPath.row];
    cell.movieTitle.text = theatreShowTime.title;
    
    NSArray *time = [theatreShowTime.showtimes valueForKey:@"dateTime"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for(NSString *string in time)
    {
        NSArray *array = [string componentsSeparatedByString:@"T"];
        if(array.count > 1)
            [tempArray addObject:[array objectAtIndex:1]];
    }
    NSString *timeStr = [tempArray componentsJoinedByString:@" "];
    cell.movieShowTime.text = [NSString stringWithFormat:@"%@",timeStr];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
        NSString *url = [NSString stringWithFormat:@"http://developer.tmsimg.com/%@?api_key=5dmhgfxxzv2y43kwhuzv8ap8",theatreShowTime.uri];
        NSURL * imageUrl=[NSURL URLWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        cell.posterImageView.image=[UIImage imageWithData:imageData];
        //cell.imageView.image = [UIImage imageWithData:imageData];
        
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            // UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
            //cell.imageView.image = [UIImage imageWithData:imageData];
            cell.posterImageView.image=[UIImage imageWithData:imageData];
            
        });
    });
    movieRootId = theatreShowTime.rootId;
    cell.playTrailer.tag = indexPath.row;
    [[cell playTrailer] addTarget:self action:@selector(playMovieClip:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(IBAction) playMovieClip:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int indexrow = btn.tag;
    TheatreShowTime *theatreShowTime = _theatresShowTime[indexrow];
    
    NSString *url = [NSString stringWithFormat:@"%@%d%@", @"http://data.tmsapi.com/v1/screenplayTrailers?rootids=",theatreShowTime.rootId, @"&bitrateids=461&api_key=5dmhgfxxzv2y43kwhuzv8ap8"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jasonParsingError = nil;
    
    NSArray *jasonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &jasonParsingError];
    
    if([jasonArray count]>0)
    {
        dataList=jasonArray;
    }
    
    
    NSDictionary* moviestrailerlist= [dataList valueForKey:@"response"];
    NSDictionary* moviestrailer= [moviestrailerlist valueForKey:@"trailers"];
    id val = nil;
    NSArray *values = [moviestrailer valueForKey:@"Url"];
    
    if ([values count] != 0)
        val = [values objectAtIndex:0];

    NSURL* movieclipurl = [NSURL URLWithString:val];
    
    moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:movieclipurl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
    [player stop];
    [player release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
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
