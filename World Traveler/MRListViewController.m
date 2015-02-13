//
//  MRViewController.m
//  World Traveler
//
//  Created by Mark Rabins on 9/10/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "MRListViewController.h"
#import "MRFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Venue.h"
#import "Location.h"
#import "MRMapViewController.h"
#import "MRAppDelegate.h"
#import "MRAppDelegate.h"

static NSString *const kCLIENTIT = @"W4VTZIIDGPBV1N521E1IPJLHB1EV4BRBHOI1HFUTUCSYFN3O";
static NSString *const kCLIENTSECRET = @"DHSLURUMYQRDRYKOKFM0UATM0GEODSVOTITAR0CV3KDHIYDO";

#define latitudeOffset 0.01
#define longitudeOffset 0.01

@interface MRListViewController () <CLLocationManagerDelegate>

@property (strong,nonatomic) NSArray *venues;
@property (strong,nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)refreshBtn:(UIBarButtonItem *)sender;

@end

@implementation MRListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
    
    MRFourSquareSessionManager *sessionManager = [MRFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
   
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    MRMapViewController *mapVC = segue.destinationViewController;
    mapVC.venue = venue;
}

#pragma mark -IBActions

- (IBAction)refreshBtn:(UIBarButtonItem *)sender
{
    [self.locationManager startUpdatingLocation];
}

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [[self drawControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    [self.locationManager startUpdatingLocation];
    
    [[MRFourSquareSessionManager sharedClient] GET: [NSString stringWithFormat:@"venues/search?ll=%f,%f", location.coordinate.latitude + latitudeOffset,location.coordinate.longitude + longitudeOffset]
     parameters:@{@"client_id" :kCLIENTIT, @"client_secret" :kCLIENTSECRET, @"v" : @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *venues = responseObject;
        self.venues = venues;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
    
}

#pragma mark - DrawerController

-(MMDrawerController *)drawControllerFromAppDelegate
{
    MRAppDelegate *appDelegate = (MRAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end
