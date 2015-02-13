//
//  MRMenuViewController.m
//  World Traveler
//
//  Created by Mark Rabins on 9/15/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "MRMenuViewController.h"
#import "MRListViewController.h"
#import "MRAppDelegate.h"

@interface MRMenuViewController ()

@property (strong,nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UINavigationController *listNavigationController;

@property (strong,nonatomic) UINavigationController *favoriteVenuesNavigationController;
@property (strong, nonatomic) UINavigationController *addVenueNavigationController;

@end

@implementation MRMenuViewController

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if (!self.viewControllers){
        self.viewControllers = [[NSMutableArray alloc] initWithCapacity:3];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (!self.listNavigationController)
    {
        MMDrawerController *drawController = [self drawControllerFromAppDelegate];
        self.listNavigationController = (UINavigationController *)drawController.centerViewController;
        [self.viewControllers addObject:self.listNavigationController];
    }
    if (!self.favoriteVenuesNavigationController)
    {
        self.favoriteVenuesNavigationController = (UINavigationController *)
        [mainStoryboard instantiateViewControllerWithIdentifier:@"MRFavoriteVenueViewControllerID"];
        [self.viewControllers addObject:self.favoriteVenuesNavigationController];
    }
    if (!self.addVenueNavigationController)
    {
        self.addVenueNavigationController = (UINavigationController *)
        [mainStoryboard instantiateViewControllerWithIdentifier:@"MRAddVenueViewControllerID"];
        [self.viewControllers addObject:self.addVenueNavigationController];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITablViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewControllers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0){
        cell.textLabel.text = @"Home";
    }
    else if (indexPath.row ==1){
        cell.textLabel.text = @"Favorites";
    }
    else if (indexPath.row ==2){
        cell.textLabel.text = @"Add";
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMDrawerController *drawController = [self drawControllerFromAppDelegate];
    [drawController setCenterViewController:self.viewControllers[indexPath.row] withCloseAnimation:YES completion:nil];
}

#pragma mark - DrawController Helper

-(MMDrawerController *)drawControllerFromAppDelegate
{
    MRAppDelegate *appDelegate = (MRAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end

