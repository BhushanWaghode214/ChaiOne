//
//  Memory.h
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Posts : NSObject

@property (nonatomic, strong) NSMutableArray *serverPostsData;

-(void)fetchPostsFromServerWithSuccessBlock:(RequestSuccessBlock)successBlock
                        andErrorBlock:(RequestErrorBlock)errorBlock;

@end
