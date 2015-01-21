//
//  ShareManager.h
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Posts.h"
#import "WebServices.h"

@interface SharedManager : NSObject

@property (nonatomic, strong) Posts *postsManager;

@property (nonatomic, strong) WebServices *webServiceManager;

+(SharedManager *)defaultManager;

@end
