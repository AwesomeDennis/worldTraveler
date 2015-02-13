//
//  FSCategory.h
//  World Traveler
//
//  Created by Mark Rabins on 9/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TCRecord.h"

@class Venue;

@interface FSCategory : TCRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Venue *venue;

@end
