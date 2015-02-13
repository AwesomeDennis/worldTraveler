//
//  MRDirectionsViewController.m
//  World Traveler
//
//  Created by Mark Rabins on 9/12/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "MRDirectionsViewController.h"
#import "MRDirectionsListViewController.h"

@interface MRDirectionsViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *directionsMap;

@property (strong, nonatomic) CLLocationManager *locationManager;


- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

@implementation MRDirectionsViewController

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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    self.directionsMap.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender
{
   [self performSegueWithIdentifier:@"directionToList" sender:nil];
}

#pragma mark - Segue

 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.destinationViewController isKindOfClass:[MRDirectionsListViewController class]])
 {
     MRDirectionsListViewController *directionsListVC = segue.destinationViewController;
     directionsListVC.steps = self.steps;
    }
 }

 
#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];
    
    self.directionsMap.showsUserLocation = YES;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000);
    [self.directionsMap setRegion:[self.directionsMap regionThatFits:region] animated:YES];
    
    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    [self getDirections:destinationMapItem];
    
}

#pragma mark - Directions Helper

-(void)getDirections:(MKMapItem *)destination
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = YES;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error)
        {
            NSLog(@"%@", error);
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to preform request. Please try again shortly" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [error show];
        }
        else {
            [self showRoute:response];
        }
    }];
}

#pragma mark - Route Helper

-(void)showRoute:(MKDirectionsResponse *)response
{
    self.steps = response.routes;
    
    for(MKRoute *route in self.steps){
        [self.directionsMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        //    for (MKRouteStep *step in route.steps){
        //  NSLog(@"%@", step.instructions);
        //}
    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 3.0;
    
    return renderer;
}

@end
