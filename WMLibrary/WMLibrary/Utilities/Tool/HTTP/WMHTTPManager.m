//
//  ICHTTPManager.m
//  iCoffeeLibrary
//
//  Created by Shengzhe Chen on 8/20/13.
//  Copyright (c) 2013 iCoffee. All rights reserved.
//

#import "WMHTTPManager.h"

@interface WMHTTPManager ()

@property (nonatomic, strong) WMHTTPURLConnectionDelegate *connectionDelegate;
@property (nonatomic, strong) WMHTTPURLConnection *connection;

@property (nonatomic, copy) void(^completionHandler)(WMHTTPURLResponse *response);
@end

@implementation WMHTTPManager

- (id)initWithURIString:(NSString *)uriString
                   body:(NSDictionary *)body
                  token:(NSString *)token
                 HTTPMethod:(NSString *)method
            completionHandler:(void(^)(WMHTTPURLResponse *response))completionHandler
{
    self = [super init];
    
    if (self)
    {
        WMMutableURLRequest *request = [WMMutableURLRequest requestWithURLString:uriString
                                                                      HTTPMethod:method
                                                                            body:body
                                                                           token:token];
        self.connectionDelegate = [[WMHTTPURLConnectionDelegate alloc] initWithDelegate:self];
        self.connection = [[WMHTTPURLConnection alloc] initWithRequest:request
                                                                      delegate:self.connectionDelegate];
        self.completionHandler = completionHandler;
    }
    
    return self;
}


- (void)executeCompletionHandlerWithResponse:(WMHTTPURLResponse *)response
{
    if (self.completionHandler)
    {
        self.completionHandler(response);
    }
}


- (void)start
{
    [self.connection start];
}


+ (WMHTTPManager *)GETHTTPManagerWithURLString:(NSString *)URI
                                         token:(NSString *)token
                             completionHandler:(void(^)(WMHTTPURLResponse *response))completionHandler
{
    return [[WMHTTPManager alloc] initWithURIString:URI
                                               body:nil
                                              token:token
                                         HTTPMethod:@"GET"
                                  completionHandler:completionHandler];
}


+ (WMHTTPManager *)PUTHTTPManagerWithURLString:(NSString *)URI
                                          body:(NSDictionary *)body
                                         token:(NSString *)token
                             completionHandler:(void(^)(WMHTTPURLResponse *response))completionHandler
{
    return [[WMHTTPManager alloc] initWithURIString:URI
                                               body:body
                                              token:token
                                         HTTPMethod:@"PUT"
                                  completionHandler:completionHandler];
}


+ (WMHTTPManager *)POSTHTTPManagerWithURLString:(NSString *)URI
                                           body:(NSDictionary *)body
                                         token:(NSString *)token
                             completionHandler:(void(^)(WMHTTPURLResponse *response))completionHandler
{
    return [[WMHTTPManager alloc] initWithURIString:URI
                                               body:body
                                              token:token
                                         HTTPMethod:@"POST"
                                  completionHandler:completionHandler];
}

@end
