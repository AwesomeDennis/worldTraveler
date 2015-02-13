//
//  MRAddVenueViewController.h
//  World Traveler
//
//  Created by Mark Rabins on 10/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRAddVenueViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *venueNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *typeOfFoodTextField;

- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)menuBarButtonItemButtonPressed:(UIBarButtonItem *)sender;


@end
