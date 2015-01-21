//
//  ShareManager.m
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import "SharedManager.h"

@implementation SharedManager

-(Posts *)postsManager{
    if (_postsManager) {
        return _postsManager;
    }
    _postsManager = [[Posts alloc]init];
    return _postsManager;
}

-(WebServices *)webServiceManager{
    if (_webServiceManager) {
        return _webServiceManager;
    }
    _webServiceManager = [[WebServices alloc]initWithHostName:MAIN_URL];
    [_webServiceManager useCache];
    
    return _webServiceManager;
}

static SharedManager *sharedInstance = nil;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+(SharedManager *)defaultManager{
    if (sharedInstance == nil) {
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            sharedInstance = [[self alloc] init];
        });
    }
    
    return sharedInstance;
}

@end
