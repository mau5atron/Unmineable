//
//  NetworkRequest.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/27/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

+ (void)unmineableRestAPIBalanceRequestWithBaseURI:(NSString* _Nonnull)baseURI coinAddress:(NSString* _Nonnull)address coinType:(NSString* _Nonnull)type callback:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))block {
	NSMutableURLRequest *apiRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/address/%@?coin=%@", baseURI, address, type]]];
	
	[apiRequest setHTTPMethod:@"GET"];
	[apiRequest setTimeoutInterval:10.0f];
	[apiRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:NULL delegateQueue:[NSOperationQueue mainQueue]];
	
	NSURLSessionDataTask *requestDataTask = [
			session
			dataTaskWithRequest:apiRequest
		  completionHandler:block
  ];
	
	[requestDataTask resume];
}

+ (void)bitfinexRestAPITickerTradeValueRequestWithBaseURI:(NSString * _Nonnull)baseURI tickerEndpoint:(NSString * _Nonnull)endpoint tickerParameter:(NSString * _Nonnull)coinTickerType callback:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))block {
	NSMutableURLRequest *apiRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@", baseURI, endpoint, coinTickerType]]];
	
	[apiRequest setHTTPMethod:@"GET"];
	[apiRequest setTimeoutInterval:10.0f];
	[apiRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:NULL delegateQueue:[NSOperationQueue mainQueue]];
	
	NSURLSessionDataTask *requestDataTask = [
			session
		  dataTaskWithRequest:apiRequest
			completionHandler:block
  ];
	
	[requestDataTask resume];
}

@end
