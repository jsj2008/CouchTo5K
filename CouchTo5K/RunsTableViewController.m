//
//  RunsTableViewController.m
//  CouchTo5K
//
//  Created by Peter Friese on 12.03.12.
//  Copyright (c) 2012 peterfriese.de. All rights reserved.
//

#import "RunsTableViewController.h"
#import "DatabaseAdapter.h"
#import <CouchCocoa/CouchCocoa.h>
#import <CouchCocoa/CouchTouchDBServer.h>
#import <CouchCocoa/CouchUITableSource.h>
#import <CouchCocoa/CouchDesignDocument_Embedded.h>
#import "PlotRunMapViewController.h"

@interface RunsTableViewController ()
@property(nonatomic, strong)  CouchUITableSource* dataSource;
@end


@implementation RunsTableViewController

@synthesize dataSource;

#pragma mark - CouchDB view

- (void)setupView
{
    self.dataSource = [[CouchUITableSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    self.dataSource.tableView = self.tableView;
    self.dataSource.query = [[DatabaseAdapter sharedAdapter] queryRuns];
//    self.dataSource.labelProperty = @"text";    // Document property to display in the cell label
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Run Log";
    [self setupView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Couch table source delegate

// Customize the appearance of table view cells.
- (void)couchTableSource:(CouchUITableSource*)source
             willUseCell:(UITableViewCell*)cell
                  forRow:(CouchQueryRow*)row
{
    // Set the cell background and font:
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.textLabel.font = [UIFont fontWithName: @"Helvetica" size:18.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    // Configure the cell contents. Our view function (see above) copies the document properties
    // into its value, so we can read them from there without having to load the document.
    // cell.textLabel.text is already set, thanks to setting up labelProperty above.
    cell.textLabel.text = row.key;
//    cell.detailTextLabel.text = [properties objectForKey:@"user"];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id run = [self.dataSource.rows objectAtIndex:[indexPath row]];
    
    PlotRunMapViewController *plotRunMapViewController = [[PlotRunMapViewController alloc] init];
    plotRunMapViewController.title = [run valueForKey:@"key"];
    plotRunMapViewController.runKey = [run valueForKey:@"key"];
    [self.navigationController pushViewController:plotRunMapViewController animated:YES];
}

@end
