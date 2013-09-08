//
//  ICMutableURLRequest.h
//  iCoffeeLibrary
//
//  Created by Shengzhe Chen on 8/20/13.
//  Copyright (c) 2013 iCoffee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMMutableURLRequest : NSMutableURLRequest

+ (WMMutableURLRequest *)GETRequestWithURIString:(NSString *)uriString
                                           token:(NSString *)token;


+ (WMMutableURLRequest *)PUTRequestWithURIString:(NSString *)uriString
                                            body:(NSDictionary *)body
                                           token:(NSString *)token;


+ (WMMutableURLRequest *)POSTRequestWithURIString:(NSString *)uriString
                                             body:(NSDictionary *)body
                                            token:(NSString *)token;

+ (id)requestWithURLString:(NSString *)URLString
                HTTPMethod:(NSString *)HTTPMethod
                      body:(NSDictionary *)body
                     token:(NSString *)token;

@end
