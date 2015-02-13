//
//  MRFourSquareSessionManager.h
//  World Traveler
//
//  Created by Mark Rabins on 9/11/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface MRFourSquareSessionManager : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
