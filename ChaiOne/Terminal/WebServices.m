//
//  WebServices.m
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
    // Nandakishor



#import "WebServices.h"

@implementation WebServices

-(MKNetworkOperation *)fetchPostsFromServerWithSuccessBlock:(RequestSuccessBlock)successBlock
                                                             andErrorBlock:(RequestErrorBlock)errorBlock{
    
    MKNetworkOperation *op = [self operationWithPath:USERSPOST_URL
                                              params:nil
                                          httpMethod:HTTP_METHOD
                                                 ssl:YES];
    
    [op addCompletionHandler: ^(MKNetworkOperation *completedOperation) {
        DebugLog(@"Success! curlString= %@ %@", completedOperation.url, completedOperation.responseJSON);
            NSDictionary *responseFromServer = completedOperation.responseJSON;
            successBlock(responseFromServer);
    }
    errorHandler: ^(MKNetworkOperation *completedOperation, NSError *error) {
        DebugLog(@"Error! curlString=%@", completedOperation.curlCommandLineString);
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}


@end
