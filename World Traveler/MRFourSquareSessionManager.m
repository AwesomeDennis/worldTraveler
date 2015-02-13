//
//  MRFourSquareSessionManager.m
//  World Traveler
//
//  Created by Mark Rabins on 9/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "MRFourSquareSessionManager.h"

static NSString *const MRFourSquareBaseURLString = @"https://api.foursquare.com/v2/";

@implementation MRFourSquareSessionManager

+(instancetype)sharedClient
{
    static MRFourSquareSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MRFourSquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:MRFourSquareBaseURLString]];
    });
    return _sharedClient;
}

@end
