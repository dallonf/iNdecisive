//
//  DetailViewController.h
//  iNdecsisive
//
//  Created by Dallon Feldner on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id detailItem;


@property (weak, nonatomic) IBOutlet UILabel *decisionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *decisionLabel2;

@property (retain) NSMutableArray *optionList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(NSString *)loopedOption:(NSInteger)index;

@end
