//
//  PostData.h
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (nonatomic, strong) NSURL *avatarImageUrl;
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *date;
@end
