//
//  Location.h
//  World Traveler
//
//  Created by Mark Rabins on 9/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TCRecord.h"

@class Venue;

@interface Location : TCRecord

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * cc;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * crossStreet;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) Venue *venue;

@end
