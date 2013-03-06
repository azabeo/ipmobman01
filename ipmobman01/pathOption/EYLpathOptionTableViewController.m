//
//  EYLpathOptionTableViewController.m
//  ipmobman01
//
//  Created by Alex Zabeo on 29/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLpathOptionTableViewController.h"

@interface EYLpathOptionTableViewController ()

@end

@implementation EYLpathOptionTableViewController

EYLnavigationControllerDelegate* nav;
EYLrouteOption* option;
UIActivityIndicatorView *pathActivityIndicator;
int didShowURL = 0;

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
    
    self.title = NSLocalizedString(@"Trip info", @"Trip info");
    
    nav = (EYLnavigationControllerDelegate*)self.navigationController.delegate;
    option = nav.selectedTripOption;
    
    LogDebug(@"SEL %@",option.description);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 + [option.steps count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return nil;
    }
    
    if (section==[option.steps count]+1) {
        return NSLocalizedString(@"Actions", @"Actions");
    }
    else {
        return nil;    
    }
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView;
    if (section==0) {
        return nil;
        /*
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)];
        [headerView setBackgroundColor:[UIColor clearColor]];
         */
    } 
    if (section==[option.steps count]+1) {
        /*
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)];
        label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section]; 
        label.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
        label.backgroundColor = [UIColor clearColor];
        [headerView addSubview:label];
         */
        return nil;
    }
    else {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        
        EYLrouteStep* step = [option getStepAtIndex:section-1];
        
#define totWidth 320
#define totHeight 50
        
#define imgTopMargin 0
#define imgHorizMargin 10
#define spaceAfterImg 10
        
#define hSpaceBetweenText 10
#define vSpaceBetweenText 0
        
#define imgHeight 40
#define imgWidth 40
        
#define textLeftMargin (imgHorizMargin + imgWidth + spaceAfterImg)
        
#define mainTextTopMargin 0
#define mainTextWidth (totWidth - (textLeftMargin * 2))
        
#define mainTextHeight 20
        
#define afterTextTop (mainTextTopMargin + mainTextHeight + vSpaceBetweenText)
        
#define textWidth ((mainTextWidth - hSpaceBetweenText) / 2)
#define travelTextWidth ((mainTextWidth - (hSpaceBetweenText * 3)) / 4)
        
#define textHeight (totHeight - afterTextTop)
        
#define secondAfterTextLeftMargin (textLeftMargin + textWidth + hSpaceBetweenText)
        
#define secondImgLeftMargin (totWidth - imgHorizMargin - imgWidth) 
        
#define mainTextColor 0x8FFFDF
#define mainTexSize 0
#define texSize 10
        
        
        CGPoint imgPos = CGPointMake (imgHorizMargin, imgTopMargin);
        CGPoint secondImgPos = CGPointMake (secondImgLeftMargin, imgTopMargin);
        CGSize imgSize = CGSizeMake (imgWidth,imgHeight);
        
        UIImageView *im = [EYLtripResultsParser getImageForTravelMode:step.travel_mode withFrame:CGRectMake(imgPos.x,imgPos.y, imgSize.width, imgSize.height)];
        [headerView addSubview:im];
                        
        if (step.isWalk) {
            
            CGRect recDesc = CGRectMake(textLeftMargin, mainTextTopMargin, mainTextWidth, mainTextHeight);
            CGRect recDur = CGRectMake(textLeftMargin, afterTextTop, textWidth, textHeight);
            CGRect recDis = CGRectMake(secondAfterTextLeftMargin, afterTextTop, textWidth, textHeight);
            
            [EYLutilities insertTextLabelWithFrame:recDesc Text:step.description textSize:mainTexSize bkgColor:nil inView:headerView];
            [EYLutilities insertTextLabelWithFrame:recDur Text:step.duration textSize:texSize bkgColor:Nil inView:headerView];
            [EYLutilities insertTextLabelWithFrame:recDis Text:step.distance textSize:texSize bkgColor:Nil inView:headerView]; 
            
            im = [EYLutilities getPngImageForName:@"navigator" withFrame:CGRectMake(secondImgPos.x,secondImgPos.y, imgSize.width, imgSize.height)];
            [headerView addSubview:im];

        } else {
            CGRect recDesc = CGRectMake(textLeftMargin, mainTextTopMargin, mainTextWidth, mainTextHeight);
            CGRect recStartTime = CGRectMake(textLeftMargin, afterTextTop, travelTextWidth, textHeight);
            CGRect recEndTime = CGRectMake((textLeftMargin + travelTextWidth + hSpaceBetweenText), afterTextTop, travelTextWidth, textHeight);
            CGRect recDur = CGRectMake((textLeftMargin + ((travelTextWidth + hSpaceBetweenText)*2)), afterTextTop, travelTextWidth, textHeight);
            CGRect recStops = CGRectMake((textLeftMargin + ((travelTextWidth + hSpaceBetweenText)*3)), afterTextTop, travelTextWidth, textHeight);            
            
            [EYLutilities insertTextLabelWithFrame:recDesc Text:[[step.transit_details.short_name stringByAppendingString:@" "] stringByAppendingString:step.description] textSize:mainTexSize bkgColor:nil inView:headerView];
            [EYLutilities insertTextLabelWithFrame:recStartTime Text:step.transit_details.start_time textSize:texSize bkgColor:nil inView:headerView];
            [EYLutilities insertTextLabelWithFrame:recEndTime Text:step.transit_details.end_time textSize:texSize bkgColor:nil inView:headerView];
            [EYLutilities insertTextLabelWithFrame:recDur Text:step.duration textSize:texSize bkgColor:nil inView:headerView];
            NSString* s = [step.transit_details.num_stops stringByAppendingString:NSLocalizedString(@" Stops", @" Stops")];
            [EYLutilities insertTextLabelWithFrame:recStops Text:s textSize:texSize bkgColor:nil inView:headerView];
            
            EYLWebViewWithName* webView = [[EYLWebViewWithName alloc] initWithFrame:CGRectMake(secondImgPos.x,secondImgPos.y, imgSize.width, imgSize.height)];
            
            NSString *path = [[NSBundle mainBundle] bundlePath];
            NSURL *baseURL = [NSURL fileURLWithPath:path];
            NSString *testString = @"<style type=\"text/css\"> body{ margin: 0; padding: 0; } </style> ";
            testString = [[testString stringByAppendingString:@"<a href=\""] stringByAppendingString:step.transit_details.company_url ];
            testString = [[testString stringByAppendingString:@"\"><img src=\""] stringByAppendingString:[EYLtripResultsParser getImageNameForCompany:step.transit_details.company_name ]];
            testString = [[[[[testString stringByAppendingString:@"\" height=\""] stringByAppendingString:[NSString stringWithFormat:@"%i",imgHeight]] stringByAppendingString:@"\" width=\""] stringByAppendingString:[NSString stringWithFormat:@"%i",imgWidth]] stringByAppendingString:@"\"></a>"];
            
            LogDebug(@"%@",testString);
            
            [webView loadHTMLString:testString baseURL:baseURL];
            
            webView.delegate=self;
            webView.name = @"carrier";
            
            webView.backgroundColor = [UIColor clearColor];
            [headerView addSubview:webView];
        }
    }
        
    return headerView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([webView isKindOfClass:[EYLWebViewWithName class]]) {
        EYLWebViewWithName* wv = (EYLWebViewWithName*)webView;
        if ([wv.name isEqualToString:@"map"]) {
            [pathActivityIndicator stopAnimating];
            wv.hasLoaded=true;
        }
    }
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request  navigationType:(UIWebViewNavigationType)navigationType{
    
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
        
    return TRUE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
        
    }
    if (section==[option.steps count]+1) {
        return 30;
    }else {
        return totHeight;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    
    if (section==[option.steps count]+1) {
        return 3;
    }
    else {
        if ([[option getStepAtIndex:section-1 ] isWalk]) {
            return [[option getStepAtIndex:section-1 ].substeps count];
        } else {
            return 3;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    if (indexPath.section==0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"mapCell"];
        
        EYLWebViewWithName* webView = (EYLWebViewWithName *)[cell viewWithTag:1];
        
        if (!webView.hasLoaded) {
            pathActivityIndicator = (UIActivityIndicatorView *)[cell viewWithTag:2];
            [pathActivityIndicator startAnimating];
            webView.backgroundColor = [UIColor clearColor];
            
            webView.delegate = self;
            webView.name = @"map";
            
            NSString* urlAddress = pathMapSericeUrl;
            urlAddress = [urlAddress stringByAppendingString:[option getUrlpart]];
            LogDebug(@"URL %@",urlAddress);
            
            urlAddress = [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            LogDebug(@"URL %@",urlAddress);
            
            NSURL *url = [NSURL URLWithString: urlAddress];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
            [webView loadRequest: request];
        }
        
        return cell;
    }
    if (indexPath.section==[option.steps count]+1) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"actionCell"];
        
        NSString* imgName;
        NSString* text;
        
        switch (indexPath.row) {
            case 0:
                imgName = @"tickets";
                text = NSLocalizedString(@"Buy tickets", @"Buy tickets");
                break;
                
            case 1:
                imgName = @"favs";
                text = NSLocalizedString(@"Add to favorites", @"Add to favorites");
                break;
                
            case 2:
                imgName = @"floppy";
                text = NSLocalizedString(@"Save for offline", @"Save for offline");
                break;
                
            default:
                break;
        }
        
        NSURL* plistURL = [[NSBundle mainBundle] URLForResource:imgName withExtension:@"png"];
        UIImageView *imv = (UIImageView *)[cell viewWithTag:1];
        imv.image = [UIImage imageWithContentsOfFile:[plistURL path]];
        
        ((UILabel *)[cell viewWithTag:2]).text = text;
        ((UILabel *)[cell viewWithTag:2]).adjustsFontSizeToFitWidth = YES;
        
        return cell;
    }
    else { 
        if ([[option getStepAtIndex:indexPath.section - 1] isWalk]) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"walkStepCell"];
            
            EYLrouteSubStep* substep = [[option getStepAtIndex:(indexPath.section - 1)] getSubStepAtIndex:indexPath.row];
            
            if (substep) {
                //#DA QUI 
                //mettere una wuiwebview nel protitipo di cella per far vedere le indicazioni corrette
                //cell.textLabel.text = substep.description;
                
                //UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(secondImgPos.x,secondImgPos.y, imgSize.width, imgSize.height)];
                
                EYLWebViewWithName* webView = (EYLWebViewWithName *)[cell viewWithTag:1];
                
                NSString *path = [[NSBundle mainBundle] bundlePath];
                NSURL *baseURL = [NSURL fileURLWithPath:path];
                NSString *testString = @"<style type=\"text/css\"> body{ margin: 0; padding: 0; background-color: #F7F7F7; font-size:15px;}  </style> ";
                testString = [testString stringByAppendingString:substep.description];
                
                LogDebug(@"%@",testString);
                
                [webView loadHTMLString:testString baseURL:baseURL];
                
                //webView.delegate=self;
                
                webView.backgroundColor = [UIColor clearColor];
                
                UILabel *cellLabel = (UILabel *)[cell viewWithTag:2];
                cellLabel.text = substep.distance;
                
                cellLabel = (UILabel *)[cell viewWithTag:3];
                cellLabel.text = substep.duration;
                
                cellLabel = (UILabel *)[cell viewWithTag:4];
                cellLabel.text = [NSString stringWithFormat:@"%i",indexPath.row + 1];
            }
            
        } else {
            if (indexPath.row < 2) {
                cell = [self.tableView dequeueReusableCellWithIdentifier:@"travelStepCell"];
                cell.textLabel.adjustsFontSizeToFitWidth=YES;
                if (indexPath.row == 0) {
                    cell.textLabel.text = [option getStepAtIndex:(indexPath.section - 1)].transit_details.start_name;
                }else {
                    [cell.textLabel setText:[option getStepAtIndex:(indexPath.section - 1)].transit_details.end_name];
                }
                
            }else{
                cell = [self.tableView dequeueReusableCellWithIdentifier:@"travelStepCellOptions"];
                
                UIButton *but = (UIButton *)[cell viewWithTag:1];
                [but setTitle:NSLocalizedString(@"Buy ticket", @"But ticket") forState:UIControlStateNormal];
                
                but = (UIButton *)[cell viewWithTag:2];
                [but setTitle:NSLocalizedString(@"Activate", @"Activate") forState:UIControlStateNormal];
            }
            
        }
        
        return cell;
        
    }    
    
    

    
    /*
    
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
#define textWidth 34
#define textHeight 10
        
#define textLeftMargin 170
#define afterMainTextLeft textLeftMargin + mainTextWidth + spaceBetweenText
#define afterMainTextTop 15
#define afterTextLeft textLeftMargin + textWidth + spaceBetweenText
#define afterTextTop 30
        
#define mainTextColor 0x8FFFDF
        
        CGPoint imgPos = CGPointMake (topMargin, leftMargin);
        CGSize imgSize = CGSizeMake (imgWidth,imgHeight);
        
        for (EYLrouteStep* step in option.steps) {
            
            LogDebug(@"MODE: %@",step.travel_mode);
            
            UIImageView *im = [tripParser getImageForTravelMode:step.travel_mode withFrame:CGRectMake(imgPos.x,imgPos.y, imgSize.width, imgSize.height)];
            [cell.contentView addSubview:im];
            imgPos.x += im.frame.size.width + spaceBetweenImg;
        }        
        //row width = 300
        CGRect recDur = CGRectMake(textLeftMargin, topMargin, mainTextWidth, mainTextHeight);
        CGRect recDis = CGRectMake(afterMainTextLeft, afterMainTextTop, textWidth, textHeight);
        CGRect recstart = CGRectMake(textLeftMargin, afterTextTop, textWidth, textHeight);
        CGRect recEnd = CGRectMake(afterTextLeft, afterTextTop, textWidth, textHeight);
        
        [self insertTextLabelWithFrame:recDur Text:option.duration textSize:0 bkgColor:UIColorFromRGB(mainTextColor) inCell:cell];
        [self insertTextLabelWithFrame:recDis Text:option.distance textSize:13 bkgColor:Nil inCell:cell];
        [self insertTextLabelWithFrame:recstart Text:option.startTime textSize:13 bkgColor:Nil inCell:cell];
        [self insertTextLabelWithFrame:recEnd Text:option.endTime textSize:13 bkgColor:Nil inCell:cell];
        
    }
     */
    
    
}

- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 276;
    }
    if (indexPath.section==[option.steps count]+1) {
        //default height 44
        return t.rowHeight;
    }
    else {
        if ([[option getStepAtIndex:indexPath.section-1 ] isWalk]) {
            return 88;
        }else {
            return t.rowHeight;
        }
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
