//
//  Constants.h
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef webserviceSample_Constants_h
#define webserviceSample_Constants_h


#pragma mark - URL

#define MAIN_URL @"alpha-api.app.net"
#define USERSPOST_URL @"stream/0/posts/stream/global"
#define HTTP_METHOD @"GET"

#if defined(ADHOC) || defined(DEBUG)
#   define DebugLog(fmt, ...) {NSLog((fmt), ##__VA_ARGS__);}
#else
#   define DebugLog(...)
#endif

#pragma mark - Memory
static NSString *const kDATA = @"data";
static NSString *const kMETA = @"meta";
static NSString *const kUSERNAME = @"username";
static NSString *const kAVATARIMAGE = @"avatar_image";
static NSString *const kURL = @"url";
static NSString *const kUSER = @"user";
static NSString *const kTEXT = @"text";
static NSString *const kCELL = @"DetailCell";
static NSString *const kCREATED_AT = @"created_at";


#pragma mark - Comman Blocks
typedef void (^RequestSuccessBlock) (id parsedObjects);
typedef void (^RequestErrorBlock) (NSError *error);

#endif
