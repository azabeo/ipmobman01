//
//  EYLselectTripOptionTableViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 08/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//




#import "EYLselectTripOptionTableViewController.h"

@interface EYLselectTripOptionTableViewController ()

//@property (strong, nonatomic) NSArray* options;

@end

@implementation EYLselectTripOptionTableViewController
@synthesize optionsActivityIndicator;
@synthesize optionsTableView;

//@synthesize options;
//@synthesize optionsDictionary;

EYLnavigationControllerDelegate* nav;
EYLtripResultsParser* tripParser;

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
    
    nav = (EYLnavigationControllerDelegate*)self.navigationController.delegate;
    
    //self.options = [NSArray arrayWithObjects:@"ciao", @"secondo", @"terxo", nil];
    
    dispatch_async(kBgQueue, ^{
        [self performSelectorOnMainThread:@selector(getRemoteData) 
                               withObject:Nil waitUntilDone:YES];
    });
    
    self.title = NSLocalizedString(@"Trip options", @"Trip options");
}

- (void)viewDidUnload
{

    [self setOptionsActivityIndicator:nil];
    [self setOptionsTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - remoteDataProtocol implementation

- (void) getRemoteData{
    LogDebug(@"getOptions");
    
    EYLremoteConnection* connection = [[EYLremoteConnection alloc] init];
    connection.delegate = self;
    
    [optionsActivityIndicator startAnimating];
    
    [connection getTripOptionsWithOrigin:nav.from Destination:nav.to IsDeparture:nav.isDeparture When:[nav whenEpoch] Language:nav.language IsMetric:nav.isMetric];
}

-(void) setDataDictionary:(NSDictionary *)dDictionary{
    LogDebug(@"ISRECEIVED");
    
    //self.optionsDictionary = dDictionary;
    
    [optionsActivityIndicator stopAnimating];
    
    tripParser = [[EYLtripResultsParser alloc] initWithDictionary:dDictionary];
    
    //IF error: alert
    if ([(NSString*)[[tripParser getStatus] objectAtIndex:0] isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:(NSString*)[[tripParser getStatus] objectAtIndex:1] delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil];
        [alert show];
    }
    
    [optionsTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return nil;
    }else {
        return NSLocalizedString(@"Options", @"Options");
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else {
        if (tripParser) {
            return [tripParser countOptions];
        }else {
            return 0;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;

    if (indexPath.section==0) {
        CellIdentifier = @"recapCell";
    }else {
        CellIdentifier = @"optionCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (indexPath.section==0) {       
        ((UILabel *)[cell viewWithTag:1]).text = NSLocalizedString(@"From:", @"From:");
        ((UILabel *)[cell viewWithTag:2]).text = NSLocalizedString(@"To:", @"To:");
        ((UILabel *)[cell viewWithTag:3]).text = [nav departureString];
        ((UILabel *)[cell viewWithTag:4]).text = nav.from;
        ((UILabel *)[cell viewWithTag:5]).text = nav.to;
        ((UILabel *)[cell viewWithTag:6]).text = [nav whenString];
    }else {
        //((UILabel *)[cell viewWithTag:1]).text = [tripParser getOptionAtPosition:indexPath.row];
        
        //#TODO completare la creazione delle opzioni
        
        EYLrouteOption* option = [tripParser getOptionAtPosition:indexPath.row];
        
#define topMargin 2
#define leftMargin 2
#define spaceBetweenImg 2
#define spaceBetweenText 6
        
#define imgHeight 40
#define imgWidth 40
        
#define mainTextWidth 60
#define mainTextHeight 25
#define textWidth 40
#define textHeight 15
        
#define textLeftMargin 170
#define afterMainTextLeft textLeftMargin + mainTextWidth + spaceBetweenText
#define afterMainTextTop 10
#define afterTextLeft textLeftMargin + textWidth + spaceBetweenText
#define afterTextTop 25
        
#define mainTextColor 0x8FFFDF
                
        CGPoint imgPos = CGPointMake (leftMargin, topMargin);
        CGSize imgSize = CGSizeMake (imgWidth,imgHeight);
        
        for (EYLrouteStep* step in option.steps) {
            
            LogDebug(@"MODE: %@",step.travel_mode);
            
            UIImageView *im = [EYLtripResultsParser getImageForTravelMode:step.travel_mode withFrame:CGRectMake(imgPos.x,imgPos.y, imgSize.width, imgSize.height)];
            [cell.contentView addSubview:im];
            imgPos.x += im.frame.size.width + spaceBetweenImg;
        }        
        //row width = 300
        CGRect recDur = CGRectMake(textLeftMargin, topMargin, mainTextWidth, mainTextHeight);
        CGRect recDis = CGRectMake(afterMainTextLeft, afterMainTextTop, textWidth, textHeight);
        CGRect recstart = CGRectMake(textLeftMargin, afterTextTop, textWidth, textHeight);
        CGRect recEnd = CGRectMake(afterTextLeft, afterTextTop, textWidth, textHeight);
        
        [EYLutilities insertTextLabelWithFrame:recDur Text:option.duration textSize:0 bkgColor:UIColorFromRGB(mainTextColor) inView:cell.contentView];
        [EYLutilities insertTextLabelWithFrame:recDis Text:option.distance textSize:13 bkgColor:Nil inView:cell.contentView];
        [EYLutilities insertTextLabelWithFrame:recstart Text:option.startTime textSize:0 bkgColor:Nil inView:cell.contentView];
        [EYLutilities insertTextLabelWithFrame:recEnd Text:option.endTime textSize:0 bkgColor:Nil inView:cell.contentView];
        
    }
    
    return cell;
}
/*
-(void)insertTextLabelWithFrame:(CGRect)frame Text:(NSString*)text textSize:(int)textSize bkgColor:(UIColor*)color inCell:(UITableViewCell*)cell{
    //textSize = 0 means automatic text size
    UILabel* test;
    
    test = [[UILabel alloc] initWithFrame:frame];
    
    test.adjustsFontSizeToFitWidth = YES;
    if (textSize) {
        test.font = [UIFont systemFontOfSize:(CGFloat)textSize];
    }
    
    test.text =  text;
    test.textAlignment = UITextAlignmentCenter;
    if (color) {
        test.backgroundColor = color;
    }
    
    //test.frame = [EYLutilities getFrameForText:test.text inLabel:test maximumSize:size];
    
    [cell.contentView addSubview:test];
}
 */

- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 110;
    } else {
        //default height 44
        return t.rowHeight;
    }
}

#pragma mark - UIAlertViewDelegate implementation

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)alertViewCancel:(UIAlertView *)alertView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        nav.selectedTripOption = [tripParser getOptionAtPosition:indexPath.row];
        [self performSegueWithIdentifier:@"tripOptionSegue" sender:nil];
    }
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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



@end
