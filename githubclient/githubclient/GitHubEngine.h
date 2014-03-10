//
//  GitHubEngine.h
//  githubclient
//
//  Created by David on 10/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UAGithubEngine/UAGithubEngine.h>
#import "UserObject.h"

@interface GitHubEngine : NSObject{
    UAGithubEngine *engine;
    UserObject *userfinded;
    
}

@property (nonatomic, strong) UAGithubEngine *engine;

@property BOOL finded;

+ (GitHubEngine *) sharedSingleton;

- (void) authenticate;

- (BOOL) searchUser :(NSString *) user;
- (UserObject *) getUser;

@end
