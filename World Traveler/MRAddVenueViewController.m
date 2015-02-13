//
//  MRAddVenueViewController.m
//  World Traveler
//
//  Created by Mark Rabins on 10/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "MRAddVenueViewController.h"
#import "MRAppDelegate.h"
#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"


@interface MRAddVenueViewController ()

@end

@implementation MRAddVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButtonPressed:(UIButton *)sender
{
    if ([self.venueNameTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Blank Field!" message:@"Please Enter a Venue Name" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        Venue *venue = [Venue MR_createEntity];
        venue.name = self.venueNameTextField.text;
        Contact *contact = [Contact MR_createEntity];
        contact.phone = self.phoneNumberTextField.text;
        venue.contact = contact;
        FSCategory *category = [FSCategory MR_createEntity];
        category.name = self.typeOfFoodTextField.text;
        venue.categories = category;
        venue.favorite = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    }
}

- (IBAction)menuBarButtonItemButtonPressed:(UIBarButtonItem *)sender
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
