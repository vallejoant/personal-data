//
//  UserObject.h
//  githubclient
//
//  Created by David on 10/03/14.
//  Copyright (c) 2014 D. Vallejo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *webpage;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *followers;
@property (nonatomic, strong) NSNumber *following;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSArray* repositories;

@end
