//
//  NetworkRequest.h
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/27/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#ifndef NetworkRequest_h
#define NetworkRequest_h

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface NetworkRequest : NSObject

+ (void)unmineableRestAPIBalanceRequestWithBaseURI:(NSString* _Nonnull)baseURI coinAddress:(NSString* _Nonnull)address coinType:(NSString* _Nonnull)type callback:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))block;

+ (void)bitfinexRestAPITickerTradeValueRequestWithBaseURI:(NSString * _Nonnull)baseURI tickerEndpoint:(NSString * _Nonnull)endpoint tickerParameter:(NSString * _Nonnull)coinTickerType callback:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))block;

@end

#endif /* NetworkRequest_h */
