//
//  ICHTTPManager.h
//  iCoffeeLibrary
//
//  Created by Shengzhe Chen on 8/20/13.
//  Copyright (c) 2013 iCoffee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WMHTTPURLConnectionDelegate.h"
#import "WMHTTPURLConnection.h"
#import "WMMutableURLRequest.h"
#import "WMHTTPURLResponse.h"

@interface WMHTTPManager : NSObject


+ (WMHTTPManager *)GETHTTPManagerWithURLString:(NSString *)URI
                                         token:(NSString *)token
                             completionHandler:(void(^)(WMHTTPURLResponse *response))completionHandler;


+ (WMHTTPManager *)PUTHTTPManagerWithURLString:(NSString *)URI
                                          body:(NSDictionary *)body
                                         token:(NSString *)token
                             completionHandler:(void(^)(WMHTTPURLResponse *response))completionHandler;


+ (WMHTTPManager *)POSTHTTPManagerWithURLString:(NSString *)URI
                                           body:(NSDictionary *)body
                                          token:(NSString *)token
                              completionHandler:(void(^)(WMHTTPURLResponse *response))completionHandler;


- (void)start;

@end
