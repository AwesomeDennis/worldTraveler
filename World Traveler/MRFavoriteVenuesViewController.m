//
//  MRFavoriteVenuesViewController.m
//  World Traveler
//
//  Created by Mark Rabins on 10/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "MRFavoriteVenuesViewController.h"
#import "MRAppDelegate.h"
#import "Venue.h"

@interface MRFavoriteVenuesViewController ()

@property (strong, nonatomic) NSMutableArray *favorites;

@end

@implementation MRFavoriteVenuesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    if (!self.favorites){
        self.favorites = [[NSMutableArray alloc] init];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    NSPredicate *predicateForFavorites = [NSPredicate predicateWithFormat:@"favorite == %@", [NSNumber numberWithBool:YES]];
    self.favorites = [[Venue MR_findAllWithPredicate:predicateForFavorites] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favorites count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.favorites[indexPath.row];
    cell.textLabel.text = venue.name;
    
    return cell;
}



- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender
{
     [[self drawControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - DrawController Helper

-(MMDrawerController *)drawControllerFromAppDelegate
{
    MRAppDelegate *appDelegate = ((MRAppDelegate *)[[UIApplication sharedApplication] delegate]);
    return appDelegate.drawerController;
}

@end
