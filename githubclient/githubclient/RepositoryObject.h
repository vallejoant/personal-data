//
//  RepositoryObject.h
//  githubclient
//
//  Created by David on 10/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *descript;
@property (nonatomic, strong) NSNumber *stargazers;

@end
