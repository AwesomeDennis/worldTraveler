//
//  MRMapViewController.m
//  World Traveler
//
//  Created by Mark Rabins on 9/10/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "MRMapViewController.h"
#import "Location.h"
#import "FSCategory.h"
#import "MRDirectionsViewController.h"

@interface MRMapViewController ()

@end

@implementation MRMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameLabel.text = self.venue.name;
    self.addressLabel.text = self.venue.location.address;
    
    float latitude =  [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    point.title = self.venue.name;
    point.subtitle = self.venue.categories.name;
    
    [self.mapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MRDirectionsViewController class]])
    {
        MRDirectionsViewController *directionsVC = segue.destinationViewController;
        directionsVC.venue = self.venue;
    }
}


- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"mapToDirectionSegue" sender:nil];
}

- (IBAction)favoriteVenueButtonPressed:(UIButton *)sender
{
    self.venue.favorite = [NSNumber numberWithBool:YES];
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
}


@end