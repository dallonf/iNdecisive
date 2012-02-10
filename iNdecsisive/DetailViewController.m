//
//  DetailViewController.m
//  iNdecsisive
//
//  Created by Dallon Feldner on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController;

@synthesize detailItem = _detailItem;
@synthesize decisionLabel1 = _decisionLabel1;
@synthesize decisionLabel2 = _decisionLabel2;
@synthesize optionList;
@synthesize tableView = _tableView;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(NSIntegerMax / 4) inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setDecisionLabel1:nil];
    [self setDecisionLabel2:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark Data
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NSIntegerMax / 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionSwipeCell"];
    cell.textLabel.text = @"Foo";//[self loopedOption:indexPath.row];
    
    return cell;
}

#pragma mark Events
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView setHidden:FALSE];
}


#pragma mark Functions

-(NSString *)loopedOption:(NSInteger)index {
    int id = index % self.optionList.count;
    
    return [self.optionList objectAtIndex:id];
}

@end
