//
//  MasterViewController.h
//  iNdecsisive
//
//  Created by Dallon Feldner on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *decideButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (retain) NSMutableArray *optionList;
- (IBAction)addItem:(id)sender;
- (IBAction)toggleEditMode:(id)sender;

- (void)openDialog:(NSInteger)editId;
- (void)syncDecideButton;


@end
