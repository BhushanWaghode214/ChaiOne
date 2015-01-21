//
//  WebServices.h
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface WebServices : MKNetworkEngine

-(MKNetworkOperation *)fetchPostsFromServerWithSuccessBlock:(RequestSuccessBlock)successBlock
                                                             andErrorBlock:(RequestErrorBlock)errorBlock;
@end
