//
//  MasterViewController.m
//  iNdecsisive
//
//  Created by Dallon Feldner on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@implementation MasterViewController {
    UIAlertView *_editAlert;
    int _editId;
}
@synthesize editButton;
@synthesize decideButton;
@synthesize optionList;


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _editAlert = nil;
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.toolbarHidden = NO;
    
    optionList = [[NSMutableArray alloc] init];
    
    [optionList addObject:@"Test 1"];
    [optionList addObject:@"Test 2"];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setDecideButton:nil];
    [self setEditButton:nil];
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


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return optionList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = @"OptionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
    }
    
    cell.textLabel.text = [optionList objectAtIndex:[indexPath row]];
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {   
        [optionList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self syncDecideButton];
    } 
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id option = [optionList objectAtIndex:fromIndexPath.row];
    [optionList removeObjectAtIndex:fromIndexPath.row];
    [optionList insertObject:option atIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (IBAction)toggleEditMode:(id)sender {
}

- (IBAction)addItem:(id)sender {
    [self openDialog:-1];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == _editAlert && buttonIndex == 1) {
        NSString *entry = [alertView textFieldAtIndex:0].text;
        
        if (_editId == -1) {
            if (![entry isEqualToString:@""]) {
                [optionList addObject:entry];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:optionList.count - 1 inSection:0];
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self syncDecideButton];
            }
        } else {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_editId inSection:0];
            if (![entry isEqualToString:@""]) {
                [optionList replaceObjectAtIndex:_editId withObject:entry];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                [optionList removeObjectAtIndex:_editId];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self syncDecideButton];
            }
        }
    }
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:_editId inSection:0] animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self openDialog:indexPath.row];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DecideSegue"]) {
        DetailViewController *detail = segue.destinationViewController;
        
        detail.optionList = self.optionList;
    }
}

#pragma mark Functions

-(void)openDialog:(NSInteger)editId {
    if(!_editAlert) {
        _editAlert = [[UIAlertView alloc] initWithTitle:@"Option" message:@"Please enter an option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [_editAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    }
    
    if (editId != -1) {
        [_editAlert textFieldAtIndex:0].text = [optionList objectAtIndex:editId];
    } else {
        [_editAlert textFieldAtIndex:0].text = @"";        
    }
    _editId = editId;
    
    [_editAlert show];
}

-(void)syncDecideButton {
    if (optionList.count >= 2) {
        decideButton.enabled = YES;
    } else {
        decideButton.enabled = NO;
    }
}


@end
