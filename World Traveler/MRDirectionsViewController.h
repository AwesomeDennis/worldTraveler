//
//  MRDirectionsViewController.h
//  World Traveler
//
//  Created by Mark Rabins on 9/12/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"

@interface MRDirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) NSArray *steps;


@end
