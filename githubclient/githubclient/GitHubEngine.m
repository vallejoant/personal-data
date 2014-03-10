//
//  GitHubEngine.m
//  githubclient
//
//  Created by David on 10/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import "GitHubEngine.h"
#import "RepositoryObject.h"

@implementation GitHubEngine

@synthesize engine;

static GitHubEngine *sharedSingleton = nil;

+ (GitHubEngine *)sharedSingleton
{
	@synchronized(self)
	{
		if (!sharedSingleton) {
			sharedSingleton = [[GitHubEngine alloc] init];
        }
    }
    
	return sharedSingleton;
}


- (void) authenticate
{
     engine = [[UAGithubEngine alloc] initWithUsername:@"githubclienttest" password:@"githubclienttest1" withReachability:YES];
    
    self.finded = NO;
}

- (BOOL) searchUser :(NSString *) user
{
    self.finded = NO;
    
    [engine user:user success:^( NSArray* user) {
        
        if([user count] > 0){
            
            self.finded = YES;
            userfinded = [[UserObject alloc] init];
            
            NSDictionary* dict= [[NSDictionary alloc] initWithDictionary:[user objectAtIndex:0]];
            userfinded.nickname = [dict objectForKey:@"login"];
            userfinded.fullname = [dict objectForKey:@"name"];
            userfinded.location = [dict objectForKey:@"location"];
            userfinded.webpage = [dict objectForKey:@"html_url"];
            userfinded.email = [dict objectForKey:@"email"];
            userfinded.followers = [dict objectForKey:@"followers"];
            userfinded.following = [dict objectForKey:@"following"];
            userfinded.avatar = [dict objectForKey:@"avatar_url"];
            
        }


    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    if(self.finded){
        [engine repositoriesForUser:user includeWatched:YES page:0 success:^(NSArray* repositories) {
            
            NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
            
            for (int i = 0; i < [repositories count]; i++) {
                NSDictionary* dict= [[NSDictionary alloc] initWithDictionary:[repositories objectAtIndex:i]];
                RepositoryObject* object = [[RepositoryObject alloc] init];
                
                object.name = (NSString*)[dict objectForKey:@"full_name"];
                if ([[dict objectForKey:@"description"] isKindOfClass:[NSString class]]) {
                    object.descript = [dict objectForKey:@"description"];
                }
                
                object.stargazers = [dict objectForKey:@"stargazers_count"];
                
                [array addObject:object];
            }
            
            userfinded.repositories =  [[NSArray alloc] initWithArray:array];
            
        
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    return self.finded;
}


- (UserObject *) getUser
{
    if(self.finded)
        return userfinded;
    else
        return nil;
}


@end
