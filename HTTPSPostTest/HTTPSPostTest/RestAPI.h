//
//  RestAPI.h
//  HitFlight
//
//  Created by Hamid on 7/31/14.
//  Copyright (c) 2014 HuxTek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestAPI;
@protocol RestAPIDelegate
- (void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender;
@end

@interface RestAPI : NSObject
- (void)httpRequest:(NSMutableURLRequest *)request;

@property (nonatomic, weak) id  <RestAPIDelegate> delegate;
@end

#define POST @"POST"
#define GET @"GET"
