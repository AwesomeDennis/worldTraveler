//
//  MRFavoriteVenuesViewController.h
//  World Traveler
//
//  Created by Mark Rabins on 10/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRFavoriteVenuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
