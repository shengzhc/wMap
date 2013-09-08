//
//  ICURLConnection.h
//  iCoffeeLibrary
//
//  Created by Shengzhe Chen on 8/20/13.
//  Copyright (c) 2013 iCoffee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMHTTPURLConnectionDelegate.h"
#import "WMMutableURLRequest.h"

@interface WMHTTPURLConnection : NSURLConnection

- (id)initWithRequest:(WMMutableURLRequest *)request
             delegate:(id)delegate;



@end
