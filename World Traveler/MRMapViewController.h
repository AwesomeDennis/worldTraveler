//
//  MRMapViewController.h
//  World Traveler
//
//  Created by Mark Rabins on 9/10/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface MRMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue *venue;

//IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

- (IBAction)favoriteVenueButtonPressed:(UIButton *)sender;

@end
