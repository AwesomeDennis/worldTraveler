//
//  MRDirectionsListViewController.h
//  World Traveler
//
//  Created by Mark Rabins on 9/15/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MRDirectionsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *steps;

@end
