//
//  MRMenuViewController.h
//  World Traveler
//
//  Created by Mark Rabins on 9/15/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
