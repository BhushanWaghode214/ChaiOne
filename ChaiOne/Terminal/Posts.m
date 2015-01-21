//
//  Memory.m
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import "Posts.h"
#import "Post.h"

@implementation Posts

-(NSMutableArray *)serverPostsData{
    if (_serverPostsData) {
        return _serverPostsData;
    }
    _serverPostsData = [[NSMutableArray alloc]init];
    return _serverPostsData;
}

@synthesize serverPostsData = _serverPostsData;


-(void)fetchPostsFromServerWithSuccessBlock:(RequestSuccessBlock)successBlock
                        andErrorBlock:(RequestErrorBlock)errorBlock{
    [[[SharedManager defaultManager] webServiceManager] fetchPostsFromServerWithSuccessBlock:^(id parsedObjects) {
        
        [self.serverPostsData removeAllObjects];
        
        NSArray *posts = [self postsFromServerData:parsedObjects];
        successBlock(posts);
        
    } andErrorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

-(NSArray *)postsFromServerData:(NSMutableDictionary *)serverData{
    
    if (isValidDictionary(serverData)) {
        
        NSArray *postsData = [serverData objectForKey:kDATA];
        if (isValidArray(postsData)) {
            [postsData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                NSDictionary *postInfo = [postsData objectAtIndex:idx];
                if (isValidDictionary(postInfo)) {
                    
                    Post *post = [[Post alloc]init];
                    
                    //POST
                    NSString *postFromUser = [postInfo objectForKey:kTEXT];
                    if (isValidString(postFromUser)) {
                        [post setContent:postFromUser];
                    }else{
                        DebugLog(@"Invalid String postFromUser");
                    }
                    
                    //USER INFO
                    NSDictionary *usersInfo = [postInfo objectForKey:kUSER];
                    if (isValidDictionary(usersInfo)) {
                        //NAME
                        NSString *userName = [usersInfo objectForKey:kUSERNAME];
                        if (isValidString(userName)) {
                            [post setCreatorName:userName];
                        }else{
                            DebugLog(@"Invalid String userName");
                        }
                        
                        
                        //IMAGE
                        NSDictionary *avtarInfo = [usersInfo objectForKey:kAVATARIMAGE];
                        if (isValidDictionary(avtarInfo)) {
                            
                            NSString *avatarURL = [avtarInfo objectForKey:kURL];
                            if (isValidString(avatarURL)) {
                                [post setAvatarImageUrl:[NSURL URLWithString:avatarURL]];
                                
                            }else{
                                DebugLog(@"Invalid String avatarURL");
                            }
                            
                        }else{
                            DebugLog(@"Invalid Dictionary avtarInfo");
                        }
                        
                        //CREATED AT
                        NSString *createdAt = [usersInfo objectForKey:kCREATED_AT];
                        if (isValidString(createdAt)) {
                            [post setDate:createdAt];
                        }else{
                            DebugLog(@"Invalid String createdAt");
                        }
                        
                        
                    }else{
                        DebugLog(@"Invalid Dictionary usersInfo for idx : %lu",(unsigned long)idx);
                    }
                    
                    [self.serverPostsData addObject:post];
                    
                }else{
                    DebugLog(@"Invalid Dictionary postInfo for idx : %lu",(unsigned long)idx);
                }
            }];
            
        }else{
            DebugLog(@"Invalid Array postsData");
        }
        
    }else{
        DebugLog(@"Invalid Dictionary serverData");
    }
    
    return self.sortedPostsByDate;
    
}

-(NSArray*)sortedPostsByDate {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"date"  ascending:NO];
    return [[self.serverPostsData sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]] mutableCopy];
}

@end
